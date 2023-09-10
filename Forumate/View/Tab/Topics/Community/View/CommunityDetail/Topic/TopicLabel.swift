//
//  TopicLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import Flow
import SwiftData
import SwiftUI

struct TopicLabel: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState
    #if os(iOS) || os(macOS)
    @Environment(ThemeManager.self) private var themeManager
    #endif

    let topic: Topic
    let showCategory: Bool
    
    init(topic: Topic, showCategory: Bool = false) {
        self.topic = topic
        self.showCategory = showCategory
    }
    
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    #if os(iOS) || os(visionOS) || os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif
    @Environment(\.openURL) var openURL

    private var topicURL: URL {
        state.community.host.appending(components: "t", topic.id.description)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            categoryInfo
            titleInfo
            tagInfo
            authorInfo
            extensionInfo
        }
        #if os(iOS) || os(visionOS) || os(macOS)
        .contextMenu {
            if supportsMultipleWindows {
                Button {
                    let model = state.community as (any PersistentModel) // FIXME: Workaround for Xcode 15 beta 5
                    openWindow(value: TopicDetailWindowModel(topic: topic, communityID: model.persistentModelID))
                } label: {
                    Label("Open In New Window", systemImage: "macwindow.badge.plus")
                }
            }
            Button {
                openURL(topicURL)
            } label: {
                Label("Open Topic's Link", systemImage: "link")
            }
            Divider()
            Button {
                // TODO: Mark as read feature unimplemented
                unimplementedToast.toggle()
            } label: {
                Label("Mark As Read", systemImage: "doc.text.image")
            }
            .toast(isPresented: $unimplementedToast) {
                Label("Unimplemented Feature", systemImage: "paperplane")
                    .foregroundStyle(.white)
                    .tint(Color.accentColor.opacity(0.8))
            }
        } preview: {
            TopicDetail(topic: topic)
                .frame(maxHeight: 800)
                .environmentObject(appState)
                .environmentObject(tabState)
                .environmentObject(state)
            #if os(iOS) || os(macOS)
                .environment(themeManager)
            #endif
        }
        #endif
    }
    
    @State private var unimplementedToast = false
    
    @ViewBuilder
    var categoryInfo: some View {
        if showCategory,
           let category = state.category(appState: appState, for: topic.categoryID) {
            CategoryText(category: category)
                .lineLimit(1)
                .foregroundColor(.secondary)
                .font(.caption)
        }
    }
    
    func getTopicTitle(_ topic: Topic) -> Text {
        var images: [String] = []
        if topic.closed {
            images.append("lock.fill")
        }
        if topic.pinned || topic.pinnedGlobally {
            images.append("pin.fill")
        }
        return images.reduce(Text("")) { partialResult, image in
            partialResult + Text(Image(systemName: image))
        } + Text(topic.title)
    }

    var titleInfo: some View {
        getTopicTitle(topic)
            .bold()
            .layoutPriority(1)
    }
    
    var tagInfo: some View {
        HFlow(spacing: 2) {
            ForEach(topic.tags, id: \.self) { tag in
                TagView(tag)
            }
        }
    }
    
    @Environment(\.font) private var font

    @ViewBuilder
    var authorInfo: some View {
        if let op = topic.op,
           let avatarURL = state.avatarURL(for: op.userID),
           let name = state.username(for: op.userID) {
            HStack(spacing: 5) {
                Text("by")
                    .layoutPriority(-1)
                Image(systemName: "circle.fill")
                    .foregroundColor(.clear)
                    .overlay {
                        AsyncImage(url: avatarURL) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .clipShape(Circle())
                    }
                Text(name)
            }
            .bold()
            .foregroundColor(.secondary)
            .font(.footnote)
            .lineLimit(1)
        }
    }

    var extensionInfo: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "message")
                Text(topic.postsCount.description)
            }
            HStack(spacing: 2) {
                Image(systemName: "calendar.badge.clock")
                Text("\(topic.lastPostedAt, style: .relative) ago · \(topic.lastPosterUsername)")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .lineLimit(1)
        .padding(.top, 4)
    }
}

struct TopicLabel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                TopicLabel(topic: .test)
            }
            .listStyle(.plain)
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
        .environmentObject(CommunityDetailState(community: .swift))
    }
}
