//
//  TopicDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import SwiftUI

struct TopicDetail: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    
    let topic: Topic
    var body: some View {
        List {
            categoryInfo
            titleInfo
            if let postStream = topic.postStream {
                ForEach(postStream.posts, id: \.id) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("\(topic.replyCount) Replies")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    var categoryInfo: some View {
        if let category = state.category(appState: appState, for: topic.categoryID) {
            SubcategoryLabel(category: category)
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
