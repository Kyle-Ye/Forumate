//
//  SignInViewModel.swift
//  Forumate
//
//  Created by Kyle on 2023/11/25.
//

import AuthenticationServices
import Combine
import DiscourseKit
import os.log

@Observable
class SignInViewModel: NSObject {
    private static let logger = Logger(subsystem: Logger.subsystem, category: "Account")

    // TODO: Support iOS, visionOS and macOS direct sign-in first. watchOS and tvOS support should via nearby iOS device.
    func signIn(request url: URL) {
        // https://meta.discourse.org/t/user-api-keys-specification/48536
        // Use https://sitename.com/user-api-key/new here
        #if os(iOS) || os(macOS) || os(visionOS) || os(watchOS)
        let authSession = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: APIKeyManager.callbackSchema
        ) { [weak self] url, error in
            guard let self else { return }
            if let error { // Handle the error here. An error can even be when the user cancels authentication.
                if error is ASWebAuthenticationSessionError {
                    Self.logger.info("\(error.localizedDescription)")
                } else {
                    Self.logger.error("\(error.localizedDescription)")
                }
            } else if let url {
                // TODO: async return response here
                // so that upstream can check request.nonce == response.nonce
                _ = try? processResponseURL(url: url)
            }
        }
//        authSession.presentationContextProvider = self
        // TODO: Add a setting item to decide this
        // authSession.prefersEphemeralWebBrowserSession
        authSession.start()
        #endif
    }

    func processResponseURL(url: URL) throws -> UserAPINewResponse {
        guard let components = URLComponents(string: url.absoluteString),
              let queryItems = components.queryItems,
              let payloadItem = queryItems.first(where: { $0.name == "payload" }),
              let payloadValue = payloadItem.value else {
            Self.logger.warning("Invalid callback url \(url.absoluteString)")
            throw APIKeyManagerError.invalidCallbackURL
        }
        let payload = Data(base64Encoded: payloadValue, options: .ignoreUnknownCharacters) ?? Data()
        let decryptedData = try APIKeyManager.decrypt(payload)
        let decoder = JSONDecoder()
        return try decoder.decode(UserAPINewResponse.self, from: decryptedData)
    }
}

#if os(iOS) || os(macOS) || os(visionOS)

// MARK: - ASWebAuthenticationPresentationContextProviding

extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for _: ASWebAuthenticationSession) -> ASPresentationAnchor {
        // TODO: FIXME https://stackoverflow.com/questions/60359808/how-to-access-own-window-within-swiftui-view
        ASPresentationAnchor()
    }
}
#endif
