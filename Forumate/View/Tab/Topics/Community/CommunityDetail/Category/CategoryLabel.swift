//
//  CategoryLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI
#if !os(watchOS)
// https://github.com/tevelee/SwiftUI-Flow/issues/3
import Flow
#endif

struct CategoryLabel: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var state: CommunityDetailState
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let color = Color(hex: category.color) {
                    color.frame(width: 15, height: 15)
                }
                Text(category.name)
                    .bold()
            }
            if let description = category.description {
                Text(LocalizedStringKey(description.replacingHTMLLink()))
                    .foregroundColor(.secondary)
            }
            #if !os(watchOS)
            if category.hasChildren {
                HFlow {
                    ForEach(category.subcategoryIDs, id: \.self) { id in
                        if let subcategory = appState.fetchSubCategory(communityID: state.community.id, subcategoryID: id) {
                            Button {
                                state.selectedCategories.append(subcategory)
                            } label: {
                                SubcategoryLabel(category: subcategory)
                            }
                        }
                    }
                }
            }
            #endif
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
