//
//  SupportSection.swift
//  Forumate
//
//  Created by Kyle on 2023/6/6.
//

import SwiftUI

struct SupportSection: View {
    var body: some View {
        List {
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=BUG_REPORT.yml")!) {
                    Label("Bug Report", systemImage: "link")
                }
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=FEATURE_SUGGESTION.yml")!) {
                    Label("Feature Suggestion", systemImage: "link")
                }
                Link(destination: URL(string: "https://meta.discourse.org/t/forumate-native-discourse-client-for-ios")!) {
                    Label("Discuss at Discourse Forum topic", systemImage: "link")
                }
                Link(destination: URL(string: "https://discord.gg/ZHq5PzbGmE")!) {
                    Label("Discuss at Forumate Discord Server", systemImage: "link")
                }
            } header: {
                Text("Bug Report and Feature Suggestion")
            }
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=RECOMMEND_FORUM.yml")!) {
                    Label("Suggest new Recommend Forum item", systemImage: "link")
                }
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues/new?template=NEW_ICON.yml")!) {
                    Label("Contribute new App Icon", systemImage: "link")
                }
            } header: {
                Text("Contribute to Forumate project")
            }
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate")!) {
                    Label("Browse Forumate's source code", systemImage: "link")
                }
            } header: {
                Text("Source Code")
            }
            Section {
                Link(destination: URL(string: "https://twitter.com/ForumateApp")!) {
                    Label("Follow me on Twitter", systemImage: "link")
                }
            } header: {
                Text("Other")
            }
        }
    }
}

struct SupportSection_Previews: PreviewProvider {
    static var previews: some View {
        SupportSection()
    }
}
