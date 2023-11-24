//
//  SettingView.swift
//  ForumateMac
//
//  Created by Kyle on 2023/11/24.
//

import SwiftUI
import Observation

@Observable
class SettingViewState {
    var selection: SettingsTabDestination.ID = .general
}

struct SettingView: View {
    @State var state = SettingViewState()

    var body: some View {
        TabView(selection: $state.selection) {
            GeneralSettingTab()
                .tabItem { Label("General", systemImage: "gearshape") }
                .tag(SettingsTabDestination.ID.general)
            PlusSettingTab()
                .tabItem { Label("Forumate+", systemImage: "star") }
                .tag(SettingsTabDestination.ID.forumatePlus)
            ThemeSettingTab()
                .tabItem { Label("Theme", systemImage: "globe") }
                .tag(SettingsTabDestination.ID.theme)
            SupportSettingTab()
                .tabItem { Label("Support", systemImage: "megaphone") }
                .tag(SettingsTabDestination.ID.support)
            PrivacySettingTab()
                .tabItem { Label("Privacy Policy", systemImage: "lock") }
                .tag(SettingsTabDestination.ID.privacy)
        }
        .environment(state)
        .frame(minWidth: 600, minHeight: 400)
    }
}

#Preview {
    SettingView()
}
