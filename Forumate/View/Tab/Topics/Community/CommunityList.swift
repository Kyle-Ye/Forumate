//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

struct CommunityList: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        List {
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
