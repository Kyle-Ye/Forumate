//
//  ThemeSection.swift
//  Forumate
//
//  Created by Kyle on 2023/9/3.
//

#if os(iOS) || os(macOS)
import SwiftUI

struct ThemeSection: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(PlusManager.self) private var plusManager
    @Environment(\.colorScheme) private var colorScheme
    #if os(macOS)
    @Environment(SettingViewState.self) var settingViewState
    #else
    @State private var presentSubscription = false
    #endif

    private var followSystemBinding: Binding<Bool> {
        Binding {
            themeManager.automatic
        } set: { newValue in
            if newValue {
                themeManager.appearanceState = .automatic
            } else {
                switch colorScheme {
                case .light: themeManager.appearanceState = .light
                case .dark: themeManager.appearanceState = .dark
                @unknown default:
                    themeManager.appearanceState = .light
                }
            }
        }
    }

    var body: some View {
        @Bindable var themeManager = themeManager
        Form {
            Section {
                HStack {
                    Spacer()
                    AppearanceItem(isDark: false)
                    Spacer()
                    AppearanceItem(isDark: true)
                    Spacer()
                }
                Toggle(isOn: followSystemBinding) {
                    Text("Follow System")
                }
            } header: {
                Text("Appearance")
            }
            Section {
                if plusManager.plusEntitlement {
                    Toggle(isOn: $themeManager.enableCustomColor) {
                        Text(verbatim: "👑 Forumate+")
                    }
                } else {
                    Toggle(isOn: $themeManager.enableCustomColor) {
                        Text(verbatim: "🔒 Forumate+")
                    }
                    .disabled(true)
                    .onAppear {
                        themeManager.enableCustomColor = false
                    }
                    .onTapGesture {
                        #if os(macOS)
                        settingViewState.selection = .forumatePlus
                        #else
                        presentSubscription.toggle()
                        #endif
                    }
                    #if !os(macOS)
                    .sheet(isPresented: $presentSubscription) {
                        ForumatePlusSectionSheet()
                    }
                    #endif
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
        .formStyle(.grouped)
        .controlSize(.large)
    }

    private struct AppearanceItem: View {
        var isDark: Bool
        @Environment(ThemeManager.self) private var themeManager
        @Environment(\.colorScheme) private var colorScheme

        var ratio: Double {
            #if os(macOS)
            if let screen = NSScreen.main {
                screen.frame.width / screen.frame.height
            } else {
                16 / 9
            }
            #else
            UIScreen.main.bounds.width / UIScreen.main.bounds.height
            #endif
        }

        var implicitMode: Bool {
            themeManager.automatic && ((isDark && colorScheme == .dark) || (!isDark && colorScheme == .light))
        }

        var body: some View {
            VStack {
                #if os(macOS)
                Image(systemName: "macbook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.palette)
                    .paletteSelectionEffect(.automatic)
                    .foregroundStyle(.primary, isDark ? themeManager.darkColor : themeManager.lightColor)
                    .padding()
                #else
                Rectangle()
                    .foregroundStyle(.thickMaterial)
                    .aspectRatio(ratio, contentMode: .fit)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(alignment: .bottom) {
                        HStack {
                            Circle().frame(maxHeight: 25)
                            Circle().frame(maxHeight: 25)
                            Circle().frame(maxHeight: 25)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        .foregroundStyle(isDark ? themeManager.darkColor : themeManager.lightColor)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: implicitMode ? 5 : 0)
                            .foregroundStyle(.selection)
                    }
                    .environment(\.colorScheme, isDark ? .dark : .light)
                #endif
                Label {
                    Text(isDark ? "Dark" : "Light")
                } icon: {
                    Image(systemName: "checkmark")
                        .symbolVariant(.circle)
                        .symbolVariant((isDark && themeManager.dark) || (!isDark && themeManager.light) ? .fill : .none)
                        .foregroundStyle(
                            themeManager.automatic
                                ? .secondary
                                : (isDark ? themeManager.darkColor : themeManager.lightColor)
                        )
                }
                .foregroundStyle(
                    themeManager.automatic
                        ? .secondary
                        : .primary
                )
            }
            .onTapGesture {
                if themeManager.automatic {
                    return
                }
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
    @State var themeManager = ThemeManager()
    @State var plusManager = PlusManager()
    return ThemeSection()
        .preferredColorScheme(themeManager.colorScheme)
        .tint(themeManager.accentColor)
        .environment(themeManager)
        .environment(plusManager)
}
#endif
