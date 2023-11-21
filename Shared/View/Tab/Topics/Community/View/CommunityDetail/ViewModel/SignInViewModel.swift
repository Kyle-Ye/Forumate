//
//  SignInViewModel.swift
//  Forumate
//
//  Created by Kyle on 2023/11/25.
//

import AuthenticationServices
import Combine
import DiscourseKit

class SignInViewModel: NSObject, ObservableObject {
    func signIn(request url: URL) {
        // https://meta.discourse.org/t/user-api-keys-specification/48536
        // Use https://sitename.com/user-api-key/new here
        let authSession = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: APIKeyManager.callbackSchema
        ) { [weak self] url, error in
            guard let self else { return }
            if let error { // Handle the error here. An error can even be when the user cancels authentication.
                print(error.localizedDescription)
            } else if let url {
                processResponseURL(url: url)
            }
        }
        #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
        authSession.presentationContextProvider = self
        #endif
        authSession.start()
    }

    func processResponseURL(url _: URL) {}
}

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)

// MARK: - ASWebAuthenticationPresentationContextProviding

extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for _: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
#endif
