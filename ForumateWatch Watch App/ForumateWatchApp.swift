//
//  ForumateWatchApp.swift
//  ForumateWatch Watch App
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI

@main
struct ForumateWatch_Watch_AppApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
