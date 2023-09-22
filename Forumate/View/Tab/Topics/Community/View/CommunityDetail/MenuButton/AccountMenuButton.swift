//
//  AccountMenuButton.swift
//  Forumate
//
//  Created by Kyle on 2023/8/27.
//

import SwiftUI

struct AccountMenuButton: View {
    @State private var presentAlert = false

    // Used after login
    @State private var presentPopover = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var state: CommunityDetailState

    
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
                // TODO
                openURL(state.community.host.appending(path: "login"))
            }
            Button("Sign Up") {
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
