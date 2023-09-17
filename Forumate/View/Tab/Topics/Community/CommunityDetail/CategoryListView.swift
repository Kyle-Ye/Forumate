//
//  CategoryListView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    
    var body: some View {
        Section {
            if let categories = state.categories {
                ForEach(categories, id: \.id) { category in
                    Button {
                        state.selectedCategories.append(category)
                    } label: {
                        CategoryLabel(category: category)
                    }
                }
            } else {
                ProgressView()
                    .padding()
            }
        } header: {
            CommunitySectionHeader(text: "Categories")
        }
        .task {
            guard let site = try? await state.fetchSite() else {
                return
            }
            appState.cache(id: state.community.id, endPoint: .site, value: site)
            try? await state.updateCategories()
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
            .environmentObject(AppState())
            .environmentObject(TopicsTabState())
            .environmentObject(CommunityDetailState(community: .swift))
    }
}
