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
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues")!) {
                    Label("Bug report via GitHub", systemImage: "link")
                }
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues")!) {
                    Label("Feature request via GitHub", systemImage: "link")
                }
                Link(destination: URL(string: "https://discord.gg/ZHq5PzbGmE")!) {
                    Label("Discuss at our Discord Server", systemImage: "link")
                }
            } header: {
                Text("Bug report and feature suggest")
            }
            Section {
                Link(destination: URL(string: "https://github.com/Kyle-Ye/Forumate")!) {
                    Label("Forumate source code at GitHub", systemImage: "link")
                }                
            } header: {
                Text("Browser Code")
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
