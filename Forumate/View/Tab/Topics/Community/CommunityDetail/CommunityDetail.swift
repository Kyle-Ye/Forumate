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
            List {
                switch state.viewByType {
                case .categories:
                    CategoryListView()
                    LatestTopicsView(showButton: false)
                case .latest:
                    LatestTopicsView()
                default:
                    Text("Unimplemented")
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationDestination(for: Category.self) { category in
                CategoryDetail(category: category)
            }
        }
        .navigationTitle(state.community.title)
        .environmentObject(state)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityDetail(community: .swift)
            .environmentObject(AppState())
            .environmentObject(TopicsTabState())
    }
}
