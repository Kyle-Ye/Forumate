//
//  CommunityView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import SwiftUI

struct CommunityDetail: View {
    init(community: Community) {
        _state = StateObject(wrappedValue: CommunityDetailState(community: community))
    }
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @StateObject private var state: CommunityDetailState
        
    var body: some View {
        Group {
            #if os(watchOS)
            List { content }
                .listStyle(.plain)
                .navigationDestination(for: Topic.self) { topic in
                    TopicDetail(topic: topic)
                        .onAppear {
                            tabState.selectedTopic = topic
                        }
                        .environmentObject(appState)
                        .environmentObject(state)
                }
                .navigationDestination(for: Category.self) { category in
                    CategoryDetail(category: category)
                        .environmentObject(state)
                }
            #else
            NavigationStack(path: $state.selectedCategories) {
                List(selection: $tabState.selectedTopic) {
                    content
                }
                .listStyle(.plain)
            }
            #endif
        }
        .toolbar {
            ViewByMenuButton()
        }
        .navigationTitle(state.community.title)
        .environmentObject(state)
    }
    
    @ViewBuilder
    var content: some View {
        switch state.viewByType {
        case .categories:
            CategoryListView()
            LatestTopicsView()
        case .latest:
            LatestTopicsView()
        default:
            Section {
                Text("Unimplemented")
            } header: {
                CommunitySectionHeader(text: state.viewByType.rawValue.uppercased())
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityDetail(community: .swift)
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
    }
}
