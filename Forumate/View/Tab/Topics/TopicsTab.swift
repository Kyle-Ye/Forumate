//
//  TopicsTab.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct TopicsTab: View {
    @StateObject var tabState = TopicsTabState()
    
    var body: some View {
        NavigationSplitView(columnVisibility: $tabState.columnVisibility,
                            preferredCompactColumn: $tabState.column) {
            TopicsTabRoot()
                .environmentObject(tabState)
        } content: {
            NavigationStack(path: $tabState.selectedCategories) {
                if let community = tabState.selectedCommunity {
                    CommunityDetail(community: community)
                        .navigationDestination(for: Category.self) { category in
                            CategoryDetail(category: category)
                                .environmentObject(CommunityDetailState(community: community))
                        }
                        .id(community.id)
                } else {
                    PlaceholderView(text: "No Community Selected",
                                    image: "rectangle.3.group.bubble.left")
                }
            }
        } detail: {
            if let community = tabState.selectedCommunity,
               let topic = tabState.selectedTopic {
                TopicDetail(topic: topic)
                    .environmentObject(CommunityDetailState(community: community))
                    .id(topic.id)
            } else {
                PlaceholderView(text: "No Topic Selected")
            }
        }
        .navigationSplitViewStyleType(SplitViewStyleTypeSetting.value)
        .environmentObject(tabState)
    }
}

struct TopicsTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            #if os(iOS)
            TopicsTab()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone")
            TopicsTab()
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad")
            #else
            TopicsTab()
            #endif
        }
        .environmentObject(AppState())
    }
}
