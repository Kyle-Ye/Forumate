//
//  AppState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/8.
//

import DiscourseKit
import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    @AppStorage("is_first_launch") private var _isFirstLaunch = true
    var isFirstLaunch: Bool { _isFirstLaunch }
    
    @AppStorage("starter_intro_version") private var starterIntroVersion = 0
    var shouldShowStarterIntro: Bool { starterIntroVersion < AppInfo.starterIntroVersion }
    
    // TODO: Migrate to use CoreData or others to add iCloud sync Support
    @AppStorage("communities") private var _communities: [Community] = []
    var communities: [Community] { _communities }
    
    func didFirstLaunch() {
        _isFirstLaunch = false
        if _communities.isEmpty {
            _communities = [.swift]
        }
    }
    
    func updateStarterIntro() {
        starterIntroVersion = AppInfo.starterIntroVersion
    }
    
    func addCommunity(_ community: Community) {
        _communities.append(community)
    }
    
    func removeCommunity(_ community: Community) {
        _communities.removeAll { $0.id == community.id }
    }
    
    // MARK: Cache
    
    private var memoryCache: [UUID: Cache] = [:]
    
    typealias Cache = [String: Any]
    
    func cache<Value>(id: UUID, endPoint: Endpoint<Value>, value: Value) {
        var cache = memoryCache[id] ?? Cache()
        cache[endPoint.rawValue] = value
        memoryCache[id] = cache
    }

    func get<Value>(id: UUID, endPoint: Endpoint<Value>) -> Value? {
        memoryCache[id]?[endPoint.rawValue] as? Value
    }
    
    func fetchCategory(communityID: UUID, categoryID: Int) -> Category? {
        guard let site = get(id: communityID, endPoint: .site),
              let subcategory = site.categories.first(where: { $0.id == categoryID }) else {
            return nil
        }
        return subcategory
    }
}
