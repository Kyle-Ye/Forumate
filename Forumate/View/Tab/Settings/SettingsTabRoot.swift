//
//  SettingsTabRoot.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Observation
import SwiftUI

struct SettingsTabRoot: View {
    @EnvironmentObject private var appState: AppState
    @Environment(SettingsTabState.self) private var tabState
        
    @State private var showStarterIntro = false

    func navigationItem(destination: SettingsTabDestination.ID, text: LocalizedStringKey, icon: () -> some View) -> some View {
        NavigationLink(value: SettingsTabDestination(title: text, id: destination)) {
            Label {
                Text(text)
            } icon: {
                icon()
            }
        }
    }

    var body: some View {
        @Bindable var tabState = tabState
        List(selection: $tabState.destination) {
            Section {
                navigationItem(destination: .general, text: "General") {
                    SettingIcon(icon: "gear", style: .gray)
                }
                #if DEBUG
                navigationItem(destination: .notification, text: "Notifications") {
                    SettingIcon(icon: "bell.badge.fill", style: .red)
                }
                #endif
            }
            Section {
                navigationItem(destination: .support, text: "Support") {
                    SettingIcon(icon: "megaphone.fill", style: .blue)
                }
                navigationItem(destination: .privacy, text: "Privacy Policy") {
                    SettingIcon(icon: "lock.fill", style: .purple)
                }
                navigationItem(destination: .acknowledgement, text: "Acknowledgement") {
                    SettingIcon(icon: "heart.fill", style: .pink)
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
                    showStarterIntro = true
                } label: {
                    Label("Starter Intro", systemImage: "info.circle")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
        .sheet(isPresented: $showStarterIntro) {
            appState.updateStarterIntro()
        } content: {
            StarterIntro()
        }
        .navigationTitle("Settings")
    }
}

 struct SettingsTabRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsTabRoot()
        }
        .environment(SettingsTabState())
        .environmentObject(AppState())
    }
 }
