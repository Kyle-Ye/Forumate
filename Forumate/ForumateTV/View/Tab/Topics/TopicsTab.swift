//
//  TopicsTab.swift
//  ForumateTV
//
//  Created by Kyle on 2023/11/22.
//

import SwiftUI

struct TopicsTab: View {
    @StateObject var tabState = TopicsTabState()

    var body: some View {
        TopicsTabRoot()
            .environmentObject(tabState)
            .navigationDestination(item: $tabState.selectedCommunity) { community in
                CommunityDetail(community: community)
                    .navigationDestination(for: Category.self) { category in
                        CategoryDetail(category: category)
                            .environmentObject(CommunityDetailState(community: community))
                    }
                    .navigationDestination(item: $tabState.selectedTopic) { topic in
                        TopicDetail(topic: topic)
                            .environmentObject(CommunityDetailState(community: community))
                            .id(topic.id)
                    }
                    .id(community.id)
            }
    }
}

#Preview {
    TopicsTab()
        .environmentObject(AppState())
}
