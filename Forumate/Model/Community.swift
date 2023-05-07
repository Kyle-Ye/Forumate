//
//  Community.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import Foundation

struct Community: Codable {
    var host: URL
    
    var name: String
    
//    var icon: URL
    
    /// Verify a Discourse
    init(host: URL) throws {
        self.host = host
        // TODO
        self.name = host.absoluteString
    }
    
    private init(host: URL, name: String) {
        self.host = host
        self.name = name
    }
}

extension Community: Identifiable {
    var id: URL { host }
}

extension Community {
    static var swift = Community(host: URL(string: "https://forums.swift.org")!, name: "Swift Forums")
}
