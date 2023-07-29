//
//  AppState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/8.
//

import DiscourseKit
import Foundation
import SwiftUI
import SwiftData

@MainActor
class AppState: ObservableObject {
    @AppStorage("is_first_launch") private var _isFirstLaunch = true
    var isFirstLaunch: Bool { _isFirstLaunch }
    
    @AppStorage("starter_intro_version") private var starterIntroVersion = 0
    var shouldShowStarterIntro: Bool { starterIntroVersion < AppInfo.starterIntroVersion }
    
    @Environment(\.modelContext) private var context
    
    func didFirstLaunch() throws {
        _isFirstLaunch = false
        let descriptor: FetchDescriptor<Community> = FetchDescriptor()
        let count = try context.fetchCount(descriptor)
        if count == 0 {
            context.insert(Community.swift)
        }
    }
    
    func updateStarterIntro() {
        starterIntroVersion = AppInfo.starterIntroVersion
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
