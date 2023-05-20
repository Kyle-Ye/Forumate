//
//  CommunityView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import SwiftUI

struct CommunityView: View {
    init(community: Community) {
        _state = StateObject(wrappedValue: CommunityState(community: community))
    }
    
    @StateObject private var state: CommunityState
        
    var body: some View {
        NavigationStack {
            Group {
                if let categories = state.categories {
                    List(categories, id: \.id) { category in
                        NavigationLink(value: category) {
                            Text(category.name)
                        }
                    }
                    .navigationDestination(for: Category.self) { category in
                        Text(category.name)
                    }
                } else {
                    Text("Loading")
                }
            }
            .navigationTitle("\(state.community.name) Forums")
        }
        .onAppear {
            state.fetchCategories()
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(community: .swift)
    }
}
