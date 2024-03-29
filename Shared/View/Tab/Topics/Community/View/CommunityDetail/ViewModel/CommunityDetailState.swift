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
        let store = UserDefaults(suiteName: community.id.uuidString)!
        _viewByType = AppStorage(wrappedValue: DefaultViewByTypeSetting.value, "view_by_type", store: store)
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
    
    func updateCategoryDetail() async throws {
//        let listing = try await client.fetchCategoryDetail(category)
//        listing.
//        await MainActor.run {
//            self.latestestTopics = latest.topicList.topics
//            self.users.formUnion(latest.users)
//        }
        
        // TODO: show subcategoy and topics
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
    
    enum ViewByType: String, Hashable, CaseIterable, Unspecifiable {
        case categories
        case latest
        case top
        case new
        case unread
        case bookmard
        
        static var unspecified: CommunityDetailState.ViewByType { categories }
    }
    
    @AppStorage var viewByType: ViewByType 
    
    @Published var unimplementedToast = false

    func checkUserAPISupport() async throws -> Bool {
        try await client.fetchUserAPIKeyHead().authAPIVersion == 4
    }

    func generateUserAPIKey(from request: UserAPINewRequest) -> URL? {
        client.generateUserAPIKey(from: request)
    }
}

enum DefaultViewByTypeSetting: Setting {
    typealias Value = CommunityDetailState.ViewByType
    static var key: String { "default_view_by_type" }
}
