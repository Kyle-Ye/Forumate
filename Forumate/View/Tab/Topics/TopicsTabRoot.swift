//
//  TopicsTabRoot.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct TopicsTabRoot: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var tabState: TopicsTabState
    @State private var presentNewCommunityView = false
    
    var body: some View {
        CommunityList()
            .navigationTitle("Communities")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        presentNewCommunityView = true
                    } label: {
                        Label("Add Community", systemImage: "plus.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .sheet(isPresented: $presentNewCommunityView) {
                        NewCommunity()
                    }
                }
            }
            .navigationDestination(for: Community.self) { community in
                CommunityDetail(community: community)
                    .onAppear {
                        tabState.selectedCommunity = community
                    }
            }
    }
}

struct TopicsTabRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TopicsTabRoot()
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
    }
}
