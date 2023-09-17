//
//  BoolSetting.swift
//  Forumate
//
//  Created by Kyle on 2023/9/10.
//

import Foundation
import SwiftUI

protocol BoolSetting {
    static var key: String { get }
    static var defaultValue: Bool { get }
}

// MARK: - BoolSetting + AppStorage

extension AppStorage where Value == Bool {
    init<S: BoolSetting>(_: S.Type, store: UserDefaults? = nil) {
        self.init(wrappedValue: S.defaultValue, S.key, store: store)
    }
}
