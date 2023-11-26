//
//  SupportSection.swift
//  Forumate
//
//  Created by Kyle on 2023/6/6.
//

import SwiftUI
#if os(watchOS)
import AuthenticationServices

/// A workaround to open link in watchOS platform
struct WatchLink<Label>: View where Label: View {
    init(destination: URL, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    let destination: URL
    let label: Label

    var body: some View {
        Button {
            let session = ASWebAuthenticationSession(
                url: destination,
                callbackURLScheme: nil
            ) { _, _ in
            }
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        } label: {
            label
        }
    }
}
typealias Link = WatchLink
#endif

struct SupportSection: View {
    var body: some View {
        Form {
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=BUG_REPORT.yml")!) {
                    Label("Bug Report", image: "github.fill")
                }
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=FEATURE_SUGGESTION.yml")!) {
                    Label("Feature Suggestion", image: "github.fill")
                }
                Link(destination: URL(string: "https://meta.discourse.org/t/forumate-native-discourse-client-for-ios")!) {
                    Label("Discuss at Discourse Forum Topic", image: "discourse.fill")
                }
                Link(destination: URL(string: "https://discord.gg/ZHq5PzbGmE")!) {
                    Label("Join Forumate Discord Server", image: "discord.fill")
                }
            } header: {
                Text("Bug Report and Feature Suggestion")
            }
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=RECOMMEND_FORUM.yml")!) {
                    Label("Suggest new Recommend Forum item", image: "git.pullrequest")
                }
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=NEW_ICON.yml")!) {
                    Label("Contribute new App Icon", image: "git.pullrequest")
                }
            } header: {
                Text("Contribute to Forumate project")
            }
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate")!) {
                    Label("Browse Forumate's source code", image: "logo.git.fill")
                }
            } header: {
                Text("Source Code")
            }
            Section {
                Link(destination: URL(string: "https://twitter.com/ForumateApp")!) {
                    Label("Follow me on Twitter", image: "twitter")
                }
            } header: {
                Text("Other")
            }
        }
        .symbolRenderingMode(.multicolor)
        .formStyle(.grouped)
    }
}

#Preview {
    SupportSection()
}
