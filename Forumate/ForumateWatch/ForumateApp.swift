//
//  ForumateApp.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftData
import SwiftUI

@main
struct ForumateApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) var delegate

    private let container: ModelContainer = {
        do {
            return try ModelContainer(for: Community.self, Account.self)
        } catch {
            fatalError("Failed to create app container")
        }
    }()
    
    @StateObject private var appState = AppState()
    @State private var plusManager = PlusManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(AppViewModifier())
                .environmentObject(appState)
                .environment(plusManager)
                .modelContainer(container)
                .environment(\.openURL, .authenticationSessionAction)
        }
    }
}
