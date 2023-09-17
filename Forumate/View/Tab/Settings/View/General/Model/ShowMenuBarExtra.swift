//
//  ShowMenuBarExtra.swift
//  Forumate
//
//  Created by Kyle on 2023/9/11.
//

#if os(macOS)
import Foundation

enum ShowMenuBarExtra: BoolSetting {
    static var key: String { "show_menu_bar_extra" }
    static var defaultValue: Bool { true }
}
#endif
