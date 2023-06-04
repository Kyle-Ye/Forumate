//
//  PickerStyleType.swift
//  Forumate
//
//  Created by Kyle on 2023/6/4.
//

import Foundation
import SwiftUI

enum PickerStyleType: String, Hashable, CaseIterable {
    case automatic = "Automatic"
    case navigationLink = "Navigation Link"
    #if os(iOS) || os(macOS)
    case menu = "Menu"
    #endif
}

extension PickerStyleType: Unspecifiable {
    static var unspecified: PickerStyleType { automatic }
}

enum PickerStyleTypeSetting: Setting {
    typealias Value = PickerStyleType
    static var key: String { "picker_style_type" }
}

extension View {
    @ViewBuilder
    func pickerStyleType(_ type: PickerStyleType) -> some View {
        switch type {
        case .automatic: pickerStyle(.automatic)
        case .navigationLink: pickerStyle(.navigationLink) // FIXME: Known dark text issue on iPadOS 16
        #if os(iOS) || os(macOS)
        case .menu: pickerStyle(.menu)
        #endif
        }
    }
}
