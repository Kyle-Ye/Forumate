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
        let latest = try await client.fetchLatest()
        await MainActor.run {
            self.latestestTopics = latest.topicList.topics
            self.users.formUnion(latest.users)
        }
    }
    
    func fetchSite() async throws -> Site {
        try await client.fetchSite()
    }
    
    private var client: Client
    
    @Published private(set) var categories: [Category]?
    
    @Published private(set) var latestestTopics: [Topic]?
    
    // MARK: - User

    @Published private var users: Set<User> = []

    func avatarURL(for userID: Int) -> URL? {
        guard let user = users.first(where: { $0.id == userID }),
              let url = user.avatar(size: 48),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        if components.scheme == nil {
            components.scheme = "https"
        }
        if components.host == nil {
            components.host = community.host.host()
        }
        return components.url
    }
    
    func userName(for userID: Int) -> String? {
        guard let user = users.first(where: { $0.id == userID }) else {
            return nil
        }
        return user.userName
    }
    
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
