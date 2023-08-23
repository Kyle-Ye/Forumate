//
//  ForumateApp.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI

@main
struct ForumateApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        #if os(iOS) || os(macOS)
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $model in
            if let model {
                TopicDetail(topic: model.topic)
                    .environmentObject(appState)
                    .environmentObject(CommunityDetailState(community: model.community))
            }
        }
        #endif
    }
}
