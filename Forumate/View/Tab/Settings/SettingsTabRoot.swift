//
//  SettingsTabRoot.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct SettingsTabRoot: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: SettingsTabState
    @State private var showStarterInfo = false

    func navigationItem(text: String, icon: () -> some View, destination: () -> some View) -> some View {
        NavigationLink {
            destination()
                .navigationTitle(text)
                #if os(iOS) || os(watchOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
        } label: {
            Label {
                Text(text)
            } icon: {
                icon()
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                navigationItem(text: "General") {
                    SettingIcon(icon: "gear", style: .gray)
                } destination: {
                    GeneralSection()
                }
                #if DEBUG
                navigationItem(text: "Notifications") {
                    SettingIcon(icon: "bell.badge.fill", style: .red)
                } destination: {
                    Text("Unimplemented")
                }
                #endif
            }
            Section {
                navigationItem(text: "Support") {
                    SettingIcon(icon: "megaphone.fill", style: .blue)
                } destination: {
                    SupportSection()
                }
                navigationItem(text: "Privacy Policy") {
                    SettingIcon(icon: "lock.fill", style: .purple)
                } destination: {
                    PrivacyPolicySection()
                }
                navigationItem(text: "Acknowledgement") {
                    SettingIcon(icon: "heart.fill", style: .pink)
                } destination: {
                    AcknowSection()
                }
            } footer: {
                Text("\(AppInfo.name) v\(AppInfo.version) Build \(AppInfo.buildNumber) · \(AppInfo.OSVersion)")
            }
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showStarterInfo = true
                } label: {
                    Label("Starter Intro", systemImage: "info.circle")
                        .symbolRenderingMode(.hierarchical)
                }
                .sheet(isPresented: $showStarterInfo) {
                    StarterIntro()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsTabRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsTabRoot()
        }
        .environmentObject(AppState())
        .environmentObject(SettingsTabState())
    }
}
