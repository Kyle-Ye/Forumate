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
            mainInfo
            authorInfo
            extensionInfo
        }
    }
    
    @ViewBuilder
    var categoryInfo: some View {
        if showCategory,
           let category = state.category(appState: appState, for: topic.categoryID) {
            SubcategoryLabel(category: category)
        }
    }

    var mainInfo: some View {
        HFlow(spacing: 2) {
            if topic.pinned {
                Image(systemName: "pin.fill")
            }
            Text(topic.title)
                .bold()
                .layoutPriority(1)
            ForEach(topic.tags, id: \.self) { tag in
                TagView(tag)
            }
        }
    }
    
    @ViewBuilder
    var authorInfo: some View {
        if let op = topic.op,
           let avatarURL = state.avatarURL(for: op.userID),
           let name = state.userName(for: op.userID) {
            HStack(spacing: 2) {
                Text("by")
                AsyncImage(url: avatarURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 15, height: 15)
                .clipShape(Circle())
                Text(name)
            }
            .bold()
            .foregroundColor(.secondary)
            .font(.footnote)
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
                HStack(spacing: 5) {
                    Text(topic.lastPostedAt, style: .relative)
                    Text("·")
                    Text(topic.lastPosterUsername)
                }
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

struct TopicLabel_Previews: PreviewProvider {
    static var previews: some View {
        TopicLabel(topic: .test)
            .environmentObject(AppState())
            .environmentObject(CommunityDetailState(community: .swift))
    }
}
