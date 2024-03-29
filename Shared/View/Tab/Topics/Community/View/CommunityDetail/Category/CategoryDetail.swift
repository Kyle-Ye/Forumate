//
//  CategoryDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CategoryDetail: View {
    let category: Category
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState
        
    var body: some View {
        List { // TODO: Binding to selectedSubcategoy
            subcategorySection
//            LatestTopicsView()
        }
        .listStyle(.plain)
        .navigationTitle(category.name)
    }
    
    @ViewBuilder
    var subcategorySection: some View {
        if category.hasChildren {
            ForEach(category.subcategoryIDs, id: \.self) { id in
                if let subcategory = appState.fetchCategory(communityID: state.community.id, categoryID: id) {
                    Button {
                        // FIXME: Xcode 15 beta 1: selectedCategories count: 1->2->0
                        tabState.selectedCategories.append(subcategory)
                    } label: {
                        CategoryLabel(category: subcategory)
                    }
                }
            }
        }
    }
}

struct CategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoryDetail(category: .announcements)
        }
        .environmentObject(AppState())
        .environmentObject(TopicsTabState())
        .environmentObject(CommunityDetailState(community: .swift))
    }
}
