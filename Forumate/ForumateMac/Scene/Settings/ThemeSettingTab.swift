//
//  ThemeSettingTab.swift
//  ForumateMac
//
//  Created by Kyle on 2023/11/24.
//

import SwiftUI

struct ThemeSettingTab: View {
    var body: some View {
        ThemeSection()
    }
}

#Preview {
    @State var themeManager = ThemeManager()
    @State var plusManager = PlusManager()
    return ThemeSettingTab()
        .preferredColorScheme(themeManager.colorScheme)
        .tint(themeManager.accentColor)
        .environment(themeManager)
        .environment(plusManager)
}
