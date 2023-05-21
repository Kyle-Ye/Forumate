//
//  CommunityDetailState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import Combine
import DiscourseKit
import Foundation
import SwiftUI

typealias Category = DiscourseKit.Category

class CommunityDetailState: ObservableObject {
    init(community: Community) {
        self.community = community
        client = Client(baseURL: community.host)
    }
    
    let community: Community

    func updateCategories() async throws {
        let result = try await client.fetchCategories().categories
        await MainActor.run {
            self.categories = result
        }
    }
    
    func updateLatestTopics() async throws {
        let result = try await client.fetchLatest().topicList.topics
        await MainActor.run {
            self.latestestTopics = result
        }
    }
    
    func fetchSite() async throws -> Site {
        try await client.fetchSite()
    }
    
    private var client: Client
    
    @Published private(set) var categories: [Category]?
    
    @Published private(set) var latestestTopics: [Topic]?

    enum ViewByType: String, Hashable, CaseIterable {
        case categories
        case latest
        case top
        case new
        case unread
        case bookmard
    }
    
    @Published var viewByType: ViewByType = .categories
    
    @Published var selectedCategories: [Category] = []
}
