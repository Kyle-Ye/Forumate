//
//  RecommendCommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import SwiftData
import SwiftUI

struct RecommendCommunityList: View {
    @Query var communities: [Community]
    
    var showedCommunities: [(name: String, url: URL)] {
        [Community].recommended.filter { _, url in
            communities.allSatisfy { community in
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
        .modelContainer(previewContainer)
    }
}
