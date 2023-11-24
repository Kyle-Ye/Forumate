//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    @State private var showStarterIntro = false

    var body: some View {
        TopicsTab()
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
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .previewInterfaceOrientation(.landscapeLeft)
}
