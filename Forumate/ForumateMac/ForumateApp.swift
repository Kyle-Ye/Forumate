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
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @Environment(\.openWindow) private var openWindow

    private let container: ModelContainer = {
        do {
            return try ModelContainer(for: Community.self, Account.self)
        } catch {
            fatalError("Failed to create app container")
        }
    }()

    @StateObject private var appState = AppState()

    @State private var themeManager = ThemeManager()
    @State private var plusManager = PlusManager()

    @AppStorage(ShowMenuBarExtra.self)
    private var showMenuBarExtra

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(AppViewModifier())
                .environmentObject(appState)
                .environment(plusManager)
                .modelContainer(container)
                .environment(themeManager)
        }
        .commands {
            ToolbarCommands()
        }
        WindowGroup("Topic Detail", id: "topic", for: TopicDetailWindowModel.self) { $detailModel in
            DetailWindowView(detailModel: detailModel)
                .modifier(AppViewModifier())
                .environmentObject(appState)
                .environment(plusManager)
                .environment(themeManager)
                .modelContainer(container)
        }
        MenuBarExtra("Forumate Helper", systemImage: "f.square.fill", isInserted: $showMenuBarExtra) {
            ForumateHelpMenuBar()
                .modifier(AppViewModifier())
                .environment(plusManager)
                .environment(themeManager)
        }
        Settings {
            SettingView()
                .modifier(AppViewModifier())
                .environment(plusManager)
                .environment(themeManager)
        }
        WindowGroup("Acknowledgements", id: "acknowledgements") {
            AcknowledgementsWindowView()
                .modifier(AppViewModifier())
                .environment(themeManager)
        }
        .commands {
            CommandGroup(after: .appSettings) {
                Button {
                    openWindow(id: "acknowledgements")
                } label: {
                    Text("Acknowledgements") + Text(verbatim: "...")
                }
            }
        }
        .defaultSize(width: 400, height: 300)
    }
}

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
