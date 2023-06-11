//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

struct CommunityList: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var tabState: TopicsTabState
    var body: some View {
        List(selection: $tabState.selectedCommunity) {
            content
            RecommendCommunityList()
        }
    }
        
    var content: some View {
        Section {
            ForEach(appState.communities) { community in
                NavigationLink(value: community) {
                    CommunityLabel(community: community)
                }
                #if !os(tvOS)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        appState.removeCommunity(community)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                #endif
            }
            .onDelete(perform: deleteCommunities(at:))
        } header: {
            Text("My Communities")
        }
    }
    
    private func deleteCommunities(at indexSet: IndexSet) {
        indexSet
            .map { appState.communities[$0] }
            .forEach { appState.removeCommunity($0) }
    }
}

struct CommunityList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityList()
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
    }
}
