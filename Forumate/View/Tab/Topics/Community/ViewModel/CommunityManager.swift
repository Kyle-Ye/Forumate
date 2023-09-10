//
//  CommunityManager.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import DiscourseKit
import Foundation
import os.log

final class CommunityManager {
    static let shared = CommunityManager()
    private init() {}
    
    private static let logger = Logger(subsystem: Logger.subsystem, category: "CommunityManager")
    
    func createCommunity(_ url: URL) async throws -> Community {
        let logger = CommunityManager.logger
        logger.trace("Create community begin: \(url)")
        let client = Client(baseURL: url)
        logger.trace("Fetch site info begin")
        let info = try await client.fetchSiteBasicInfo()
        logger.trace("Fetch site info success: \(info.title)")
        logger.trace("Create community end: \(url)")
        return Community(host: url, title: info.title, icon: info.appleTouchIconURL)
    }
}
