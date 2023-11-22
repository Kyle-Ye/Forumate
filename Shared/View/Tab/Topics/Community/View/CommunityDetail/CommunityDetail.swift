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
        List {
            switch state.viewByType {
            case .categories:
                CategoryListView()
                LatestTopicsView(showCategory: false)
            case .latest:
                LatestTopicsView(showCategory: true)
            default:
                Section {
                    Text("Unimplemented Feature")
                } header: {
                    CommunitySectionHeader(text: state.viewByType.rawValue.uppercased())
                }
            }
        }
        .listStyle(.plain)
        .toolbar {
            AccountMenuButton()
            ViewByMenuButton()
        }
        .navigationTitle(state.community.title)
        .environmentObject(state)
        .toast(isPresented: $state.unimplementedToast) {
            Label("Unimplemented Feature", systemImage: "paperplane")
                .foregroundStyle(.white)
                .tint(Color.accentColor.opacity(0.8))
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
