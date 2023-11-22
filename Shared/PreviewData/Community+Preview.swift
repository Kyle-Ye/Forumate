//
//  Community+Preview.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import Foundation

extension Community {
    static var swift = Community(
        host: URL(string: "https://forums.swift.org")!,
        title: "Swift Forums",
        icon: URL(string: "https://global.discourse-cdn.com/swift/optimized/1X/0a90dde98a223f5841eeca49d89dc9f57592e8d6_2_180x180.png")!
    )
}
