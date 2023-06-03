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
    @EnvironmentObject var appState: AppState
    
    init(community: Community) {
        self.community = community
        client = Client(baseURL: community.host)
        let defaultValue = UserDefaults.standard.string(forKey: SettingKeys.defaultViewByType).flatMap { ViewByType(rawValue: $0) }
        let store = UserDefaults(suiteName: community.id.uuidString)!
        _viewByType = AppStorage(wrappedValue: defaultValue ?? .categories, "view_by_type", store: store)
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
    
    func fetchTopicDetail(id: Int) async throws -> Topic {
        try await client.fetchTopicDetail(id: id)
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
        #if DEBUG
        if PreviewChecker.isPreview {
            return URL(string: "https://picsum.photos/50/50")
        }
        #endif
            
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
    
    func avatarURL(for post: Post) -> URL? {
        #if DEBUG
        if PreviewChecker.isPreview {
            return URL(string: "https://picsum.photos/50/50")
        }
        #endif
            
        guard let url = post.avatar(size: 48),
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
    
    func username(for userID: Int) -> String? {
        #if DEBUG
        if PreviewChecker.isPreview {
            return "Kyle"
        }
        #endif
        
        guard let user = users.first(where: { $0.id == userID }) else {
            return nil
        }
        return user.username
    }
    
    func category(appState: AppState, for categoryID: Int) -> Category? {
        appState.fetchCategory(communityID: community.id, categoryID: categoryID)
    }
    
    enum ViewByType: String, Hashable, CaseIterable {
        case categories
        case latest
        case top
        case new
        case unread
        case bookmard
    }
    
    @AppStorage var viewByType: ViewByType
    
    @Published var selectedCategories: [Category] = []
}
