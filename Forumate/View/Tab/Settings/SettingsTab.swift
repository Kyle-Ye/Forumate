//
//  SettingsTab.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct SettingsTab: View {
    @State private var tabState = SettingsTabState()
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            SettingsTabRoot()
        } detail: {
            NavigationStack {
                if let destination = tabState.destination {
                    Group {
                        switch destination.id {
                        case .general: GeneralSection()
                        case .notification: Text("Unimplemented")
                        case .support: SupportSection()
                        case .privacy: PrivacyPolicySection()
                        case .acknowledgement: AcknowSection()
                        }
                    }
                    .navigationTitle(destination.title)
                    #if os(iOS) || os(watchOS)
                        .navigationBarTitleDisplayMode(.inline)
                    #endif
                }
            }
        }
        .navigationSplitViewStyleType(SplitViewStyleTypeSetting.value)
        .environment(tabState)
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
            .environmentObject(AppState())
    }
}
