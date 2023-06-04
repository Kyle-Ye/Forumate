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
        NavigationSplitView(columnVisibility: .constant(.all)) {
            SettingsTabRoot()
        } content: {
            EmptyView()
        } detail: {
            EmptyView()
        }
        .navigationSplitViewStyleType(SplitViewStyleTypeSetting.value)
        .environmentObject(tabState)
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
//            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
