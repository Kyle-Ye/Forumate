//
//  APIKeyManager.swift
//  Forumate
//
//  Created by Kyle on 2023/11/25.
//

import Foundation
import Security

enum APIKeyManager {
    static let callbackSchema = "discourse"
    static let authRedirectURL = URL(string: "\(callbackSchema)://auth_redirect")!

    private static let tag = "\(Bundle.main.bundleIdentifier!).keys.user_api_key".data(using: .utf8)!

    private static func createPrivateKey() throws -> SecKey {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 2048,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag,
            ],
        ]
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        return privateKey
    }

    private static func getPrivateKey() throws -> SecKey {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecReturnRef as String: true,
        ]
        var item: CFTypeRef?
        let res = SecItemCopyMatching(attributes as CFDictionary, &item)
        if res == errSecSuccess {
            return item as! SecKey
        } else {
            return try createPrivateKey()
        }
    }

    private static func getPublicKey() throws -> SecKey? {
        let privateKey = try getPrivateKey()
        let publicKey = SecKeyCopyPublicKey(privateKey)
        return publicKey
    }

    static func getPublicKeyString() throws -> String? {
        guard let publicKey = try APIKeyManager.getPublicKey() else {
            return nil
        }
        var error: Unmanaged<CFError>?
        guard let data = SecKeyCopyExternalRepresentation(publicKey, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        let publicKeyString = (data as Data).base64EncodedString(options: .lineLength64Characters)
        return #"""
        -----BEGIN PUBLIC KEY-----
        \#(publicKeyString)
        -----END PUBLIC KEY-----
        """#
    }
}
