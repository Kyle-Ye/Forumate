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
    @StateObject private var state: CommunityDetailState
        
    var body: some View {
        NavigationStack {
            Group {
                if let categories = state.categories {
                    List(categories, id: \.id) { category in
                        NavigationLink(value: category) {
                            CategoryLabel(category: category)
                                .environmentObject(state)
                        }
                    }
                    .navigationDestination(for: Category.self) { category in
                        CategoryDetail(category: category)
                    }
                    .searchable(text: .constant("Search"))
                } else {
                    Text("Loading")
                }
            }
        }
        .navigationTitle(state.community.title)
        .task {
            guard let site = try? await state.fetchSite() else {
                return
            }
            appState.cache(id: state.community.id, endPoint: .site, value: site)
            try? await state.updateCategories()
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityDetail(community: .swift)
    }
}
