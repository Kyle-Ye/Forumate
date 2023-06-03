//
//  TopicDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import SwiftUI
import Flow

struct TopicDetail: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    
    @State var topic: Topic
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Divider()
                categoryInfo
                titleInfo
                tagInfo
                if let postStream = topic.postStream {
                    ForEach(postStream.posts, id: \.id) { post in
                        PostView(post: post)
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("\(topic.replyCount) Replies")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if topic.postStream == nil,
               let newTopic = try? await state.fetchTopicDetail(id: topic.id) {
                await MainActor.run {
                    topic = newTopic
                }
            }
        }
    }
    
    @ViewBuilder
    var categoryInfo: some View {
        if let category = state.category(appState: appState, for: topic.categoryID) {
            CategoryText(category: category)
                .lineLimit(1)
                .foregroundColor(.secondary)
                .padding(.horizontal)
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
            .padding(.horizontal)
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
        NavigationStack {
            TopicDetail(topic: .detail)
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
        .environmentObject(CommunityDetailState(community: .swift))
    }
}
