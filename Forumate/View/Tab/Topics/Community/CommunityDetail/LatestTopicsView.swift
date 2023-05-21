//
//  LatestTopicsView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct LatestTopicsView: View {
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState
    
    var showButton = true

    var body: some View {
        Section {
            if let topics = state.latestestTopics {
                ForEach(topics, id: \.id) { topic in
                    Button {
                        tabState.selectedTopic = topic
                        tabState.columnVisibility = .detailOnly
                    } label: {
                        TopicLabel(topic: topic)
                    }
                }
            } else {
                ProgressView()
                    .padding()
            }
        } header: {
            CommunitySectionHeader(text: "Latest Topics", showButton: showButton)
        }
        .task {
            try? await state.updateLatestTopics()
        }
    }
}

struct LatestTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestTopicsView()
    }
}
