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
        let decoder = JSONDecoder.discourse
        let data = #"""
        {
            "id": 1,
            "category_id": 1,
            "created_at": "2023-03-19T13:51:09.286Z",
            "title": "Very Very Very Very Long Test Title",
            "fancy_title": "Test Title",
            "posts_count": 25,
            "new_posts": 2,
            "tags": ["swift-docc"],
            "pinned": true,
            "posters": [
            {
              "description": "Original Poster",
              "user_id": -1
            },
            {
              "description": "Frequent Poster",
              "user_id": 3749
            },
            {
              "description": "Frequent Poster",
              "user_id": 553824
            },
            {
              "description": "Frequent Poster",
              "extras": null,
              "user_id": 558081
            },
            {
              "description": "Most Recent Poster",
              "extras": "latest",
              "user_id": 566394
            }
            ],
            "last_posted_at": "2023-03-26T10:08:25.549Z",
            "last_poster_username": "Nguyen"
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Topic.self, from: data)
    }
    
    static var detail: Topic {
        let decoder = JSONDecoder.discourse
        let data = try! Data(contentsOf: URL(string: "https://forums.swift.org/t/2.json")!)
        return try! decoder.decode(Topic.self, from: data)
    }
}
