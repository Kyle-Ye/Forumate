//
//  Community.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import Foundation

struct Community {
    var host: URL
    
    var name: String
    
//    var icon: URL
}

extension Community: Identifiable {
    var id: URL { host }
}

extension Community {
    static var swift = Community(host: URL(string: "https://forums.swift.org")!, name: "Swift Forums")
}
