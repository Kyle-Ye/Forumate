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
        #if os(watchOS)
        .tabViewStyle(.verticalPage(transitionStyle: .identity))
        #endif
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
        #if os(iOS) || os(visionOS)
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
