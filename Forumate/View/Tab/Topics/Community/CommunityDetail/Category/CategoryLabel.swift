//
//  CategoryLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import Flow
import SwiftUI

struct CategoryLabel: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            #if os(tvOS)
            let spacing = 30.0
            #else
            let spacing: CGFloat? = nil
            #endif
            HStack(spacing: spacing) {
                if let color = Color(hex: category.color) {
                    color
                    #if os(tvOS)
                    .frame(width: 30, height: 30)
                    #else
                    .frame(width: 15, height: 15)
                    #endif
                }
                Text(category.name)
                    .foregroundColor(.primary)
                    .bold()
            }
            if let description = category.description {
                Text(LocalizedStringKey(description.replacingHTMLLink()))
                    .foregroundColor(.secondary)
            }
            if category.hasChildren {
                HFlow {
                    ForEach(category.subcategoryIDs, id: \.self) { id in
                        if let subcategory = appState.fetchCategory(communityID: state.community.id, categoryID: id) {
                            Button {
                                state.selectedCategories.append(subcategory)
                            } label: {
                                SubcategoryLabel(category: subcategory)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CategoryLabel(category: .announcements)
            CategoryLabel(category: .evolution)
        }
    }
}
