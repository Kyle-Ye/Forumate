//
//  Topic+Preview.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import Foundation
import DiscourseKit

extension Topic {
    static var test: Topic {
        let decoder = JSONDecoder()
        let data = #"""
        {
            "id": 1,
            "created_at": "2023-03-19T13:51:09.286Z",
            "title": "Test Title"
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Topic.self, from: data)
    }
}
