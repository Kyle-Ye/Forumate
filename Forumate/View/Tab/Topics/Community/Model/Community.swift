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
    private(set) var id: UUID!
    private(set) var host: URL!
    private(set) var title: String!
    private(set) var icon: URL?
    
    init() {
        self.id = UUID()
        self.title = ""
    }
    
    init(host: URL, title: String = "", icon: URL? = nil) {
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
