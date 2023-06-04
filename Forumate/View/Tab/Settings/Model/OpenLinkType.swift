//
//  OpenLinkType.swift
//  Forumate
//
//  Created by Kyle on 2023/6/4.
//

import Foundation

#if !os(watchOS)
enum OpenLinkType: String, Hashable, CaseIterable {
    case modal = "In-App Safari"
    case safari = "Safari App"
}

extension OpenLinkType: Unspecifiable {
    static var unspecified: OpenLinkType { modal }
}

enum OpenLinkTypeSetting: Setting {
    typealias Value = OpenLinkType
    static var key: String { "open_link_type" }
}

#endif
