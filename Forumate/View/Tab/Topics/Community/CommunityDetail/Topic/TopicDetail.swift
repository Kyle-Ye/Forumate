//
//  TopicDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import Flow
import SwiftUI

struct TopicDetail: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    #if os(iOS) || os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif
    @State var topic: Topic
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                categoryInfo
                titleInfo
                tagInfo
                if let postStream = topic.postStream {
                    ForEach(postStream.posts, id: \.id) { post in
                        Divider().padding(.vertical)
                        PostView(post: post)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("\(topic.replyCount) Replies")
        #if os(iOS) || os(watchOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
            .task {
                if topic.postStream == nil,
                   let newTopic = try? await state.fetchTopicDetail(id: topic.id) {
                    await MainActor.run {
                        topic = newTopic
                    }
                }
            }
        #if os(iOS) || os(macOS)
            .toolbar(content: {
                if supportsMultipleWindows {
                    #if os(iOS)
                    let placement: ToolbarItemPlacement = .navigationBarLeading
                    #else
                    let placement: ToolbarItemPlacement = .primaryAction
                    #endif
                    ToolbarItem(placement: placement) {
                        Button {
                            openWindow(value: TopicDetailWindowModel(topic: topic, communityID: state.community.persistentModelID))
                        } label: {
                            Label("Open In New Window", systemImage: "macwindow.badge.plus")
                        }
                    }
                }
            })
        #endif
    }
    
    @ViewBuilder
    var categoryInfo: some View {
        if let category = state.category(appState: appState, for: topic.categoryID) {
            CategoryText(category: category)
                .lineLimit(1)
                .foregroundColor(.secondary)
                .padding(.bottom)
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
            .font(.title)
    }
    
    var tagInfo: some View {
        HFlow(spacing: 2) {
            ForEach(topic.tags, id: \.self) { tag in
                TagView(tag)
            }
        }
    }
}

struct TopicDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                TopicDetail(topic: .detail(for: 2))
            }
            NavigationStack {
                TopicDetail(topic: .detail(for: 8))
            }
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
        .environmentObject(CommunityDetailState(community: .swift))
    }
}
