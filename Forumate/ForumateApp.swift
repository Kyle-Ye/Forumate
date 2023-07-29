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
            return try ModelContainer(for: [Community.self, Account.self])
        } catch {
            fatalError("Failed to create app container")
        }
    }()
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .modelContainer(container)
        #if os(iOS) || os(macOS)
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $detailModel in
            if let detailModel,
               let community = container.mainContext.object(with: detailModel.communityID) as? Community {
                TopicDetail(topic: detailModel.topic)
                    .environmentObject(appState)
                    .environmentObject(CommunityDetailState(community: community))
            } else {
                PlaceholderView(text: "No Topic Detail")
            }
        }
        #endif
    }
}
