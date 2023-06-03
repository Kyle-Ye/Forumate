//
//  SettingKeys.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import Foundation

enum SettingKeys {
    static var defaultViewByType = "default_view_by_type"
    #if !os(watchOS)
    static var openLinkStyle = "open_link_style"
    #endif
}
