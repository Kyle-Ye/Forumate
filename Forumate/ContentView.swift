//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI
#if canImport(SafariServices)
import SafariServices
#endif

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var showStartedIntro = false
    
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
        .onAppear {
            if appState.isFirstLaunch {
                if !appState.hasShowedStarterIntro {
                    showStartedIntro = true
                }
                appState.didFirstLaunch()
            }
        }
        .sheet(isPresented: $showStartedIntro) {
            StarterIntro()
        }
        #if !os(watchOS)
        .environment(\.openURL, OpenURLAction { url in
            let style = UserDefaults.standard
                .string(forKey: SettingKeys.openLinkStyle)
                .flatMap { OpenLinkStyle(rawValue: $0) }
                ?? .unspecified
            switch style {
            case .modal:
                let safari = SFSafariViewController(url: url)
                let vc = UIApplication.topModalViewController
                vc?.present(safari, animated: true, completion: nil)
                return .handled
            case .safari:
                return .systemAction(url)
            }
        })
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
