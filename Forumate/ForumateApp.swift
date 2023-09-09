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
    private let container: ModelContainer = {
        do {
            return try ModelContainer(for: Community.self, Account.self)
        } catch {
            fatalError("Failed to create app container")
        }
    }()
    
    @StateObject private var appState = AppState()
    
    #if os(iOS) || os(macOS)
    @State private var themeManager = ThemeManager()
    #endif
    
    @State private var plusManager = PlusManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(AppViewModifier())
        }
        .environmentObject(appState)
        #if os(iOS) || os(macOS)
            .environment(themeManager)
        #endif
            .environment(plusManager)
            .modelContainer(container)

        #if os(iOS) || os(visionOS) || os(macOS)
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $detailModel in
            DetailWindowView(detailModel: detailModel)
                .modifier(AppViewModifier())
        }
        .environmentObject(appState)
        #if os(iOS) || os(macOS)
            .environment(themeManager)
        #endif
            .environment(plusManager)
            .modelContainer(container)
        #endif
    }
}

#if os(iOS) || os(visionOS) || os(macOS)
struct DetailWindowView: View {
    var detailModel: TopicDetailWindowModel?
    
    @EnvironmentObject private var appState: AppState
    @Environment(\.modelContext) private var context
    
    var body: some View {
        if let detailModel,
           let community = context.model(for: detailModel.communityID) as? Community {
            TopicDetail(topic: detailModel.topic)
                .environmentObject(CommunityDetailState(community: community))
        } else {
            PlaceholderView(text: "No Topic Detail")
        }
    }
}
#endif
