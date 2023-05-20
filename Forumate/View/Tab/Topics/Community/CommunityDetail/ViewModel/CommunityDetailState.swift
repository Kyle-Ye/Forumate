//
//  CommunityDetailState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import Foundation
import Combine

typealias Category = DiscourseKit.Category

class CommunityDetailState: ObservableObject {
    init(community: Community) {
        self.community = community
        client = Client(baseURL: community.host)!
    }
    
    private var client: Client
    
    let community: Community
    @Published var categories: [Category]?
    
    
    func fetchCategories() {
        Task.detached { [weak self] in
            guard let self else { return }
            categories = try await self.client.fetchCategories().categories
        }
    }
}
