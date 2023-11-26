//
//  APIKeyManager.swift
//  Forumate
//
//  Created by Kyle on 2023/11/25.
//

import Foundation
import Security
import os.log

enum APIKeyManager {
    private static let logger = Logger(subsystem: Logger.subsystem, category: "APIKeyManager")

    static let callbackSchema = "discourse"
    static let authRedirectURL = URL(string: "\(callbackSchema)://auth_redirect")!

    private static let tag = "\(Bundle.main.bundleIdentifier!).keys.user_api_key".data(using: .utf8)!

    private static var createAttributes: [String: Any] {
        [
            kSecAttrType as String: kSecAttrKeyTypeRSA as String,
            kSecAttrKeySizeInBits as String: 2048,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag,
            ],
        ]
    }

    private static var queryAttributes: [String: Any] {
        [
            kSecAttrApplicationTag as String: tag,
            kSecClass as String: kSecClassKey as String,
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate as String,
            kSecReturnRef as String: true,
        ]
    }

    private static func createPrivateKey() throws -> SecKey {
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(createAttributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        return privateKey
    }

    private static func getPrivateKey() throws -> SecKey {
        var item: CFTypeRef?
        let res = SecItemCopyMatching(queryAttributes as CFDictionary, &item)
        if res == errSecSuccess {
            return item as! SecKey
        } else {
            return try createPrivateKey()
        }
    }

    @discardableResult
    private static func deletePrivateKey() -> Bool {
        let res = SecItemDelete(queryAttributes as CFDictionary)
        return res == errSecSuccess
    }

    private static func getPublicKey() throws -> SecKey? {
        let privateKey = try getPrivateKey()
        let publicKey = SecKeyCopyPublicKey(privateKey)
        return publicKey
    }

    static func getPublicKeyString() throws -> String? {
        guard let publicKey = try getPublicKey() else {
            return nil
        }
        var error: Unmanaged<CFError>?
        guard let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        let publicKeyString = (publicKeyData as Data).base64EncodedString(options: [.lineLength64Characters])
        let publicKeyResult = #"""
        -----BEGIN RSA PUBLIC KEY-----
        \#(publicKeyString)
        -----END RSA PUBLIC KEY-----
        """#
        return publicKeyResult
    }

    static func decrypt(_ payload: Data) throws -> Data {
        let privateKey = try getPrivateKey()
        guard SecKeyIsAlgorithmSupported(privateKey, .decrypt, .rsaEncryptionPKCS1) else {
            logger.error("The generate private key does not support RSA Encryption PKCS1")
            throw APIKeyManagerError.algorithmNotSupported
        }

        var error: Unmanaged<CFError>?
        guard let decryptedData = SecKeyCreateDecryptedData(privateKey, .rsaEncryptionPKCS1, payload as CFData, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        return decryptedData as Data
    }
}

enum APIKeyManagerError: Error {
    case invalidCallbackURL
    case algorithmNotSupported
}
