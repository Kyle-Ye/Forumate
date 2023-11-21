//
//  AccountMenuButton.swift
//  Forumate
//
//  Created by Kyle on 2023/8/27.
//

import SwiftUI
import DiscourseKit

struct AccountMenuButton: View {
    @State private var presentAlert = false

    // Used after login
    @State private var presentPopover = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var state: CommunityDetailState

    @StateObject var viewModel = SignInViewModel()

    @AppStorage("forumate_client_id")
    private var clientID = UUID().uuidString

    var body: some View {
        #if os(iOS) || os(macOS) || os(tvOS)
        Button {
            presentAlert.toggle()
        } label: {
            Image(systemName: "person.crop.circle.fill.badge.plus")
                .symbolRenderingMode(.hierarchical)
        }
        .alert(
            "Add Account", 
            isPresented: $presentAlert
        ) {
            Button("Log In") {
                Task {
                    guard try await state.checkUserAPISupport() else {
                        // Forum not support user API auth
                        return
                    }
                    guard let publicKey = try? APIKeyManager.getPublicKeyString() else {
                        return
                    }
                    let appName = AppInfo.currentAppName
                    let deviceName = UIDevice.current.name
                    let request = UserAPINewRequest(
                        applicationName: "\(appName)-\(deviceName)",
                        clientID: clientID,
                        nonce: UUID().uuidString,
                        scopes: [.notifications, .sessionInfo, .write],
                        publicKey: publicKey,
                        authRedirect: APIKeyManager.authRedirectURL
                    )
                    guard let requestURL = state.generateUserAPIKey(from: request) else {
                        return
                    }
                    viewModel.signIn(request: requestURL)
                }

            }
            Button("Sign Up") {
                // Redirect to /signup web and give user UI hint to continue the login process
                openURL(state.community.host.appending(path: "signup"))
            }
            Button("Cancel", role: .cancel) { 
            }
        } message: {
            Text("By adding an account, you can reply and create topic directly on Forumate. And we can remember exactly what you've read.")
        }
        #if os(tvOS)
        .sheet(isPresented: $presentPopover) {
            Text("Unimplemented Feature")
        }
        #else
        .popover(isPresented: $presentPopover) {
            Text("Unimplemented Feature")
        }
        #endif
        #elseif os(watchOS)
        Image(systemName: "person.crop.circle.fill.badge.plus")
            .symbolRenderingMode(.hierarchical)
        #else
        EmptyView()
        #endif
    }
}

#Preview {
    AccountMenuButton()
        .environmentObject(CommunityDetailState(community: .swift))
}
