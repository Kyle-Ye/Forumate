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
        NavigationStack(path: $state.selectedCategories) {
            List(selection: $tabState.selectedTopic) {
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
            .listStyle(.plain)
        }
        
        .toolbar {
            ViewByMenuButton()
        }
        .navigationTitle(state.community.title)
        .environmentObject(state)
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
