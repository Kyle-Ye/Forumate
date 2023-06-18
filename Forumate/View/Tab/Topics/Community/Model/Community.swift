//
//  Community
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import Foundation

struct Community: Codable {
    let id: UUID
    let host: URL
    let title: String
    let icon: URL
    
    init(host: URL, title: String, icon: URL) {
        self.id = UUID()
        self.host = host
        self.title = title
        self.icon = icon
    }
    
    enum CodingKeys: CodingKey {
        case id
        case host
        case title
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: CodingKeys.id)
        self.host = try container.decode(URL.self, forKey: CodingKeys.host)
        self.title = try container.decode(String.self, forKey: CodingKeys.title)
        self.icon = try container.decode(URL.self, forKey: CodingKeys.icon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: CodingKeys.id)
        try container.encode(self.host, forKey: CodingKeys.host)
        try container.encode(self.title, forKey: CodingKeys.title)
        try container.encode(self.icon, forKey: CodingKeys.icon)
    }
}

extension Community: Identifiable {}

extension Community: Hashable {}

extension Community: JSONRawRepresentable {}

extension [Community] {
    static var recommended: [(name: String, url: URL)] {
        [
            ("Swift Forums", URL(string: "https://forums.swift.org")!),
            ("Discourse Meta", URL(string: "https://meta.discourse.org")!),
            ("OpenAI Developer Community", URL(string: "https://community.openai.com")!),
        ]
    }
}
