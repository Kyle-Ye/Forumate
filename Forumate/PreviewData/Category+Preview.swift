//
//  Category+Preview.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation

extension Category {
    static var announcements: Category {
        let decoder = JSONDecoder()
        let data = #"""
        {
            "id": 24,
            "name": "Announcements",
            "color": "231F20",
            "position": 0,
            "description": "General announcements related to the Swift project and Swift releases.",
            "description_text": "General announcements related to the Swift project and Swift releases.",
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Category.self, from: data)
    }
    
    static var evolution: Category {
        let decoder = JSONDecoder()
        let data = #"""
        {
            "id": 18,
            "name": "Evolution",
            "color": "BF1E2E",
            "position": 1,
            "description": "Topics related to the <a href=\"https://github.com/apple/swift-evolution/blob/main/process.md\">Swift Evolution Process</a>.",
            "description_text": "Topics related to the Swift Evolution Process.",
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Category.self, from: data)
    }
}
