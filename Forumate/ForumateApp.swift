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
    #if os(iOS) || os(visionOS) || os(tvOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #elseif os(watchOS)
    @WKApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #elseif os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #endif

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
    
    #if os(macOS)
    @AppStorage(ShowMenuBarExtra.self)
    private var showMenuBarExtra
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(AppViewModifier())
        }
        .environmentObject(appState)
        .environment(plusManager)
        .modelContainer(container)
        #if os(iOS) || os(macOS)
            .environment(themeManager)
            .commands {
                ToolbarCommands()
            }
        #endif

        #if os(iOS) || os(visionOS) || os(macOS)
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $detailModel in
            DetailWindowView(detailModel: detailModel)
                .modifier(AppViewModifier())
        }
        .environmentObject(appState)
        .environment(plusManager)
        .modelContainer(container)
        #if os(iOS) || os(macOS)
            .environment(themeManager)
            .commands {
                ToolbarCommands()
            }
        #endif
        #if os(macOS)
        MenuBarExtra("Forumate Helper", systemImage: "f.square.fill", isInserted: $showMenuBarExtra) {
            ForumateHelpMenuBar()
        }
        #endif
        #endif
    }
}

#if os(macOS)
import os.log
struct ForumateHelpMenuBar: View {
    private static let logger = Logger(subsystem: Logger.subsystem, category: "ForumateHelpMenuBar")
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button {
            guard let string = NSPasteboard.general.string(forType: .URL),
                  let url = URL(string: string) else {
                Self.logger.info("No valid URL in Pasterboard")
                return
            }
            // TODO: Unimplemented
            // 1. Get the communityID by url.host
            // 2. Get topic id info from url
            // 3. Update TopicDetailWindowModel to accept topic id
            // 4. Call openWindow with topic info and community info
            Self.logger.info("\(url.absoluteString) is detected. But this feature is not implemented")
        } label: {
            Text("Try to open Pasteboard URL in Forumate")
        }
    }
}
#endif

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
