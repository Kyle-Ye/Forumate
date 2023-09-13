//
//  ThemeManager.swift
//  Forumate
//
//  Created by Kyle on 2023/9/4.
//

#if os(iOS) || os(macOS)
import SwiftUI

@Observable
class ThemeManager {
    enum AppearanceState: Int, CaseIterable {
        case automatic, light, dark
    }
    
    private static var appearanceStateKey = "appearance_state"
    
    var appearanceState: AppearanceState {
        get {
            access(keyPath: \.appearanceState)
            return AppearanceState(rawValue: UserDefaults.standard.integer(forKey: Self.appearanceStateKey)) ?? .automatic
        }
        set {
            withMutation(keyPath: \.appearanceState) {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: Self.appearanceStateKey)
            }
        }
    }
    
    var automatic: Bool {
        appearanceState == .automatic
    }
    
    var light: Bool {
        get {
            appearanceState == .light
        }
        set {
            if newValue {
                appearanceState = .light
            }
        }
    }
    
    var dark: Bool {
        get {
            appearanceState == .dark
        }
        set {
            if newValue {
                appearanceState = .dark
            }
        }
    }
    
    private static var lightColorKey = "appearance_light_color"
   
    private var lightColorString: String {
        get {
            access(keyPath: \.lightColorString)
            return UserDefaults.standard.string(forKey: Self.lightColorKey) ?? ""
        }
        set {
            withMutation(keyPath: \.lightColorString) {
                UserDefaults.standard.setValue(newValue, forKey: Self.lightColorKey)
            }
        }
    }
    
    var lightColor: Color {
        get {
            access(keyPath: \.lightColor)
            if let color = Color(hex: lightColorString) {
                return color
            }
            var env = EnvironmentValues()
            env.colorScheme = .light
            let resolved = Color.accent.resolve(in: env)
            return Color(
                .sRGBLinear,
                red: Double(resolved.linearRed),
                green: Double(resolved.linearGreen),
                blue: Double(resolved.linearBlue),
                opacity: Double(resolved.opacity)
            )
        }
        set {
            withMutation(keyPath: \.lightColor) {
                UserDefaults.standard.setValue(newValue.toHex(alpha: true), forKey: Self.lightColorKey)
            }
        }
    }
    
    private static var darkColorKey = "appearance_dark_color"

    private var darkColorString: String {
        get {
            access(keyPath: \.darkColorString)
            return UserDefaults.standard.string(forKey: Self.darkColorKey) ?? ""
        }
        set {
            withMutation(keyPath: \.darkColorString) {
                UserDefaults.standard.setValue(newValue, forKey: Self.darkColorKey)
            }
        }
    }
    
    var darkColor: Color {
        get {
            access(keyPath: \.darkColor)
            if let color = Color(hex: darkColorString) {
                return color
            }
            var env = EnvironmentValues()
            env.colorScheme = .dark
            let resolved = Color.accent.resolve(in: env)
            return Color(
                .sRGBLinear,
                red: Double(resolved.linearRed),
                green: Double(resolved.linearGreen),
                blue: Double(resolved.linearBlue),
                opacity: Double(resolved.opacity)
            )
        }
        set {
            withMutation(keyPath: \.darkColor) {
                UserDefaults.standard.setValue(newValue.toHex(alpha: true), forKey: Self.darkColorKey)
            }
        }
    }
    
    private static var enableCustomColorKey = "appearance_enable_custom_color"
   
    var enableCustomColor: Bool {
        get {
            access(keyPath: \.enableCustomColor)
            return UserDefaults.standard.bool(forKey: Self.enableCustomColorKey)
        }
        set {
            withMutation(keyPath: \.enableCustomColor) {
                UserDefaults.standard.setValue(newValue, forKey: Self.enableCustomColorKey)
                if !newValue {
                    lightColorString = ""
                    darkColorString = ""
                }
            }
        }
    }
    
    var colorScheme: ColorScheme? {
        if automatic {
            return nil
        } else if light {
            return .light
        } else if dark {
            return .dark
        } else {
            return nil
        }
    }
    
    var accentColor: Color? {
        #if os(macOS)
        let color = NSColor(name: nil) { [weak self] appearance in
            guard let self,
                  let name = appearance.bestMatch(from: [.aqua, .darkAqua])
            else { return .accent }
            let color: NSColor
            if name == .aqua {
                color = NSColor(hex: lightColorString) ?? .accent
            } else if name == .darkAqua {
                color = NSColor(hex: darkColorString) ?? .accent
            } else {
                color = .accent
            }
            return color
        }
        return Color(nsColor: color)
        #else
        let color = UIColor { [weak self] trait in
            guard let self else { return .clear }
            let color: UIColor
            if trait.userInterfaceStyle == .light {
                color = UIColor(hex: lightColorString) ?? .accent
            } else if trait.userInterfaceStyle == .dark {
                color = UIColor(hex: darkColorString) ?? .accent
            } else {
                color = .accent
            }
            return color
        }
        return Color(uiColor: color)
        #endif
    }
}
#endif
