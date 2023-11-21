//
//  SettingsTab.swift
//  ForumateTV
//
//  Created by Kyle on 2023/11/22.
//

import SwiftUI

struct SettingsTab: View {
    @StateObject private var tabState = SettingsTabState()

    var body: some View {
        SettingsTabRoot()
            .navigationDestination(item: $tabState.destination) { destination in
                Group {
                    switch destination.id {
                    case .forumatePlus: ForumatePlusSection()
                    case .iconSelector: IconSelectorSection()
                    case .general: GeneralSection()
                    case .notification: Text("Unimplemented Feature")
                    case .support: SupportSection()
                    case .privacy: PrivacyPolicySection()
                    case .acknowledgement: AcknowSection()
                    }
                }
                .navigationTitle(destination.title)
            }
            .environmentObject(tabState)
    }
}

#Preview {
    NavigationStack {
        SettingsTab()
    }
    .environmentObject(AppState())
}
