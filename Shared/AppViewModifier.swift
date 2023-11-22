//
//  AppViewModifier.swift
//  Forumate
//
//  Created by Kyle on 2023/9/9.
//

import SwiftUI

struct AppViewModifier: ViewModifier {
    #if os(iOS) || os(macOS)
    @Environment(ThemeManager.self)
    private var themeManager
    #endif

    func body(content: Content) -> some View {
        content
        #if os(iOS) || os(macOS)
            .preferredColorScheme(themeManager.colorScheme)
            .tint(themeManager.accentColor)
        #endif
    }
}
