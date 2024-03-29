//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI
import SafariServices

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var showStarterIntro = false
    
    var body: some View {
        TabView {
            TopicsTab()
                .tabItem {
                    Label("Topics", systemImage: "doc.text.image")
                }
            #if DEBUG
            InboxTab()
                .tabItem {
                    Label("Inbox", systemImage: "tray")
                }
            #endif
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .onAppear {
            if appState.shouldShowStarterIntro {
                showStarterIntro = true
            }
            if appState.isFirstLaunch {
                try? appState.didFirstLaunch()
            }
        }
        .sheet(isPresented: $showStarterIntro) {
            appState.updateStarterIntro()
        } content: {
            StarterIntro()
        }
        .environment(\.openURL, OpenURLAction { url in
            let type = OpenLinkTypeSetting.value
            switch type {
            case .modal:
                let safari = SFSafariViewController(url: url)
                let vc = UIApplication.topModalViewController
                vc?.present(safari, animated: true, completion: nil)
                return .handled
            case .safari:
                return .systemAction(url)
            }
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .previewInterfaceOrientation(.landscapeLeft)
}
