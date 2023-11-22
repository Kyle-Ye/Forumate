//
//  LatestTopicsView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import DiscourseKit
import SwiftUI

struct LatestTopicsView: View {
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState
    var showCategory = false
    
    var body: some View {
        Section {
            if let topics = state.latestestTopics {
                ForEach(topics, id: \.id) { topic in
                    Button {
                        tabState.selectedTopic = topic
                        tabState.columnVisibility = .doubleColumn
                        tabState.column = .detail
                    } label: {
                        TopicLabel(topic: topic, showCategory: showCategory)
                    }
                }
            } else {
                ProgressView()
                    .padding()
            }
        } header: {
            CommunitySectionHeader(text: "Latest Topics")
        }
        .task {
            try? await state.updateLatestTopics()
        }
    }
}

struct LatestTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestTopicsView()
            .environmentObject(AppState())
            .environmentObject(TopicsTabState())
            .environmentObject(CommunityDetailState(community: .swift))
    }
}
