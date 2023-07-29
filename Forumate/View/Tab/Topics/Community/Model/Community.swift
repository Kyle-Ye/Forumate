//
//  Community
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import Foundation
import SwiftData

@Model
final class Community {
    @Attribute(.unique) let id: UUID
    let host: URL
    let title: String
    let icon: URL
    
    init(host: URL, title: String, icon: URL) {
        self.id = UUID()
        self.host = host
        self.title = title
        self.icon = icon
    }
}

extension [Community] {
    static var recommended: [(name: String, url: URL)] {
        [
            ("Swift Forums", URL(string: "https://forums.swift.org")!),
            ("Discourse Meta", URL(string: "https://meta.discourse.org")!),
            ("OpenAI Developer Community", URL(string: "https://community.openai.com")!),
        ]
    }
}
