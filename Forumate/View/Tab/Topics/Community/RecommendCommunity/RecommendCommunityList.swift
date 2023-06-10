//
//  RecommendCommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import SwiftUI

struct RecommendCommunityList: View {
    @EnvironmentObject var appState: AppState

    var showedCommunities: [(name: String, url: URL)] {
        [Community].recommended.filter { _, url in
            appState.communities.allSatisfy { community in
                community.host != url
            }
        }
    }
    
    var body: some View {
        Section {
            ForEach(showedCommunities, id: \.name) { name, url in
                RecommendCommunityLabel(name: name, url: url)
            }
        } header: {
            Text("Recommended Communities")
        }
    }
}

struct RecommendCommunityList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                RecommendCommunityList()
            }
        }
        .environmentObject(AppState())
    }
}
