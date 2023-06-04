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
                    #if os(watchOS)
                        .labelStyle(.titleOnly)
                    #endif
                }
//            InboxTab()
//                .tabItem {
//                    Label("Inbox", systemImage: "tray")
//                    #if os(watchOS)
//                        .labelStyle(.titleOnly)
//                    #endif
//                }
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    #if os(watchOS)
                        .labelStyle(.titleOnly)
                    #endif
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
        #if os(iOS) || os(macOS)
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
