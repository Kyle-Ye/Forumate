//
//  SettingsTabRoot.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct SettingsTabRoot: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @State private var showStarterInfo = false

    var body: some View {
        List {
            Section {
                Text("TODO")
            } footer: {
                Text("\(AppInfo.name) v\(AppInfo.version) Build \(AppInfo.buildNumber) · \(AppInfo.OSVersion)")
            }
        }
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
