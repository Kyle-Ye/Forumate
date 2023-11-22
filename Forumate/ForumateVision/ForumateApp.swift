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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
            #if os(iOS) || os(macOS)
                .environment(themeManager)
            #endif
        }
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $detailModel in
            DetailWindowView(detailModel: detailModel)
                .modifier(AppViewModifier())
                .environmentObject(appState)
                .environment(plusManager)
                .modelContainer(container)
        }
    }
}

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
