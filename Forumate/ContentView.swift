//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TopicsTab()
                .tabItem {
                    Label("Topics", systemImage: "doc.text.image")
                }
            InboxTab()
                .tabItem {
                    Label("Inbox", systemImage: "tray")
                }
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TopicsTabState())
    }
}
