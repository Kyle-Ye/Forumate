//
//  SettingsTab.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct SettingsTab: View {
    @StateObject private var tabState = SettingsTabState()
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            SettingsTabRoot()
                .toolbar(removing: .sidebarToggle)
        } detail: {
            NavigationStack {
                if let destination = tabState.destination {
                    Group {
                        switch destination.id {
                        case .subscription: SubscriptionSection()
                        #if os(iOS) || os(visionOS) || os(tvOS) || os(macOS)
                        case .iconSelector: IconSelectorSection()
                        #endif
                        #if os(iOS) || os(visionOS) || os(macOS)
                        case .theme: ThemeSection()
                        #endif
                        case .general: GeneralSection()
                        case .notification: Text("Unimplemented")
                        case .support: SupportSection()
                        case .privacy: PrivacyPolicySection()
                        case .acknowledgement: AcknowSection()
                        }
                    }
                    .navigationTitle(destination.title)
                    #if os(iOS) || os(visionOS) || os(watchOS)
                        .navigationBarTitleDisplayMode(.inline)
                    #endif
                } else {
                    PlaceholderView(text: "No Setting Selected",
                                    image: "gearshape")
                }
            }
        }
        .navigationSplitViewStyleType(SplitViewStyleTypeSetting.value)
        .environmentObject(tabState)
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
            .environmentObject(AppState())
    }
}
