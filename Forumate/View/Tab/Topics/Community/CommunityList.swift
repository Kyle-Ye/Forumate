//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftData
import SwiftUI

struct CommunityList: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var tabState: TopicsTabState
    
    // Query Community and add init data
    @Environment(\.modelContext) var modelContext
    @Query var communities: [Community]
    
    var body: some View {
        List(selection: $tabState.selectedCommunity) {
            content
            RecommendCommunityList()
        }
    }
        
    var content: some View {
        Section {
            ForEach(communities) { community in
                NavigationLink(value: community) {
                    CommunityLabel(community: community)
                }
                #if !os(tvOS)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        modelContext.delete(community)
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
            .map { communities[$0] }
            .forEach { modelContext.delete($0) }
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
