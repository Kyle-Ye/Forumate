//
//  CommunityManager.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import DiscourseKit
import Foundation
import os.log

extension Logger {
    fileprivate static let communityManager = Logger(subsystem: subsystem, category: "CommunityManager")
}

class CommunityManager {
    static let shared = CommunityManager()
    private init() {}
    
    func createCommunity(_ url: URL) async throws -> Community {
        Logger.communityManager.trace("Create community begin: \(url)")
        let client = Client(baseURL: url)
        Logger.communityManager.trace("Fetch site info begin")
        let info = try await client.fetchSiteBasicInfo()
        Logger.communityManager.trace("Fetch site info success: \(info.title)")
        Logger.communityManager.trace("Create community end: \(url)")
        return Community(host: url, title: info.title, icon: info.appleTouchIconURL)
    }
}
