//
//  Settings.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import Foundation
import SwiftUI

// MARK: Define

protocol Setting<Value> {
    associatedtype Value: RawRepresentable<String>
    static var key: String { get }
    static var value: Value { get }
}

protocol Unspecifiable {
    static var unspecified: Self { get }
}

extension Setting where Value: Unspecifiable {
    static var value: Value {
        UserDefaults.standard.string(forKey: Self.key)
            .flatMap { Value(rawValue: $0) } ?? .unspecified
    }
}

// MARK: - Setting + AppStorage

extension AppStorage where Value: RawRepresentable, Value.RawValue == String {
    init<S: Setting<Value>>(_: S.Type, store: UserDefaults? = nil) {
        self.init(wrappedValue: S.value, S.key, store: store)
    }
}
