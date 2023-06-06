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
                Link("Bug report via Github", destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues")!)
                Link("Feature request via Github", destination: URL(string: "https://github.com/Kyle-Ye/Forumate/issues")!)
                Link("Discuss at our Discord Server", destination: URL(string: "https://discord.gg/ZHq5PzbGmE")!)
            } header: {
                Text("Bug report and feature suggest")
            }
            Section {
                Link("Forumate source code at Github", destination: URL(string: "https://github.com/Kyle-Ye/Forumate")!)
            } header: {
                Text("Browser Code")
            }
            Section {
                Link("Follow me on Twitter", destination: URL(string: "https://twitter.com/ForumateApp")!)
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
