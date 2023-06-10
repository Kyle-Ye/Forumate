//
//  CommunityManager.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import DiscourseKit
import Foundation

class CommunityManager {
    static let shared = CommunityManager()
    private init() {}
    
    func createCommunity(_ url: URL) async throws -> Community {
        let client = Client(baseURL: url)
        let info = try await client.fetchSiteBasicInfo()
        return Community(host: url, title: info.title, icon: info.appleTouchIconURL)
    }
}
