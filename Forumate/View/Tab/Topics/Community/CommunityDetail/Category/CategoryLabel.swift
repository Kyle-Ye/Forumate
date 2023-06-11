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
    @EnvironmentObject private var tabState: TopicsTabState
    @EnvironmentObject private var state: CommunityDetailState
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            CategoryText(category: category)
                .lineLimit(1)
                .foregroundColor(.primary)
                .bold()
            if let description = category.description {
                Text(LocalizedStringKey(description.replacingHTMLLink()))
                    .foregroundColor(.secondary)
            }
            #if os(iOS) || os(macOS)
            if category.hasChildren {
                HFlow(rowSpacing: 5) {
                    ForEach(category.subcategoryIDs, id: \.self) { id in
                        if let subcategory = appState.fetchCategory(communityID: state.community.id, categoryID: id) {
                            Button {
                                tabState.navigationPath.append(category)
                            } label: {
                                CategoryText(category: subcategory)
                                    .lineLimit(1)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
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
