//
//  TopicLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import Flow
import SwiftUI

struct TopicLabel: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState

    let topic: Topic
    let showCategory: Bool
    
    init(topic: Topic, showCategory: Bool = false) {
        self.topic = topic
        self.showCategory = showCategory
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            categoryInfo
            titleInfo
            tagInfo
            authorInfo
            extensionInfo
        }
        #if !os(watchOS)
        .contextMenu {
            if UIDevice.current.userInterfaceIdiom == .pad {
                Button {
                    // Open In New Window
                } label: {
                    #if targetEnvironment(macCatalyst)
                    Label("Open In New Window", systemImage: "rectangle.badge.plus")
                    #else
                    Label("Open In New Window", systemImage: "macwindow.badge.plus")
                    #endif
                }
                Divider()
            }
            Button {} label: {
                Label("Mark as read", systemImage: "doc.text.image")
            }
        } preview: {
            TopicDetail(topic: topic)
                .frame(maxHeight: 800)
                .environmentObject(appState)
                .environmentObject(tabState)
                .environmentObject(state)
        }
        #endif
    }
    
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
