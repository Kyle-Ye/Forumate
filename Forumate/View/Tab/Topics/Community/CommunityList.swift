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
        #if os(watchOS)
        List {
            content
        }
        #else
        List(selection: $tabState.selectedCommunity) {
            content
        }
        #endif
    }
        
    var content: some View {
        Section {
            ForEach(appState.communities) { community in
                NavigationLink(value: community) {
                    CommunityLabel(community: community)
                }
            }
        } header: {
            Text("My Communities")
        }
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
