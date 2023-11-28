//
//  OpenURL+watchOS.swift
//  ForumateWatch
//
//  Created by Kyle on 2023/11/28.
//

import AuthenticationServices
import SwiftUI

extension OpenURLAction {
    static let authenticationSessionAction = OpenURLAction {
        let session = ASWebAuthenticationSession(
            url: $0,
            callbackURLScheme: nil
        ) { _, _ in
        }
        session.prefersEphemeralWebBrowserSession = true
        session.start()
        return .handled
    }
}
