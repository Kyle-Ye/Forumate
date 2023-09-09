//
//  ThemeSection.swift
//  Forumate
//
//  Created by Kyle on 2023/9/3.
//

#if os(iOS) || os(macOS)
import SwiftUI

struct ThemeSection: View {
    @Environment(ThemeManager.self) var themeManager
    
    var body: some View {
        @Bindable var themeManager = themeManager
        List {
            Section {
                HStack {
                    Spacer()
                    AppearanceItem(isDark: false)
                    Spacer()
                    AppearanceItem(isDark: true)
                    Spacer()
                }
                Toggle(isOn: $themeManager.automatic) {
                    Text("Follow System")
                }
            } header: {
                Text("Appearance")
            }
            Section {
                Toggle(isOn: $themeManager.enableCustomColor) {
                    if themeManager.isPlusUser {
                        Text(verbatim: "👑 Forumate+").textCase(nil)
                    } else {
                        Text(verbatim: "🔒 Forumate+").textCase(nil)
                    }
                }
                ColorPicker("Light", selection: $themeManager.lightColor, supportsOpacity: true)
                    .foregroundStyle(themeManager.enableCustomColor ? .primary : .secondary)
                    .disabled(!themeManager.enableCustomColor)
                ColorPicker("Dark", selection: $themeManager.darkColor, supportsOpacity: true)
                    .foregroundStyle(themeManager.enableCustomColor ? .primary : .secondary)
                    .disabled(!themeManager.enableCustomColor)
            } header: {
                VStack(alignment: .leading) {
                    Text("Theme Color Customization")
                }
            } footer: {
                Text("If you spot some theme color is not refreshed, you may consider relauching the app.")
            }
        }
    }
    
    private struct AppearanceItem: View {
        @Environment(ThemeManager.self) var themeManager
        var isDark: Bool
        
        var body: some View {
            VStack {
                Rectangle()
                    .foregroundStyle(.thickMaterial)
                    .aspectRatio(UIScreen.main.bounds.width / UIScreen.main.bounds.height, contentMode: .fit)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(alignment: .bottom) {
                        HStack {
                            Circle().frame(maxHeight: 50)
                            Circle().frame(maxHeight: 50)
                            Circle().frame(maxHeight: 50)
                        }
                        .padding(.horizontal)
                        .foregroundStyle(isDark ? themeManager.darkColor : themeManager.lightColor)
                    }
                    .environment(\.colorScheme, isDark ? .dark : .light)
                Label(isDark ? "Dark" : "Light", systemImage: "checkmark")
                    .symbolVariant(.circle)
                    .symbolVariant((isDark && themeManager.dark) || (!isDark && themeManager.light) ? .fill : .none)
                
            }
            .onTapGesture {
                if isDark {
                    themeManager.dark = true
                } else {
                    themeManager.light = true
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var themeManager = ThemeManager()
        var body: some View {
            ThemeSection()
                .environment(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
                .tint(themeManager.accentColor)
        }
    }
    return Preview()
}
#endif
