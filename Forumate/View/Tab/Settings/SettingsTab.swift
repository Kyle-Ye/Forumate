//
//  SettingsTab.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct SettingsTab: View {
    @StateObject var tabState = SettingsTabState()
    
    var body: some View {
        NavigationView {
            SettingsTabRoot()
                .environmentObject(tabState)
        }
        #if os(iOS) || os(macOS)
        .navigationViewStyle(.columns)
        #endif
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
            .environmentObject(AppState())
    }
}
