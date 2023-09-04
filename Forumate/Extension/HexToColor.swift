//
//  HexToColor.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

extension UIColor {
    convenience init?(hex string: String, opacity: Double = 1.0) {
        if let color = Color(hex: string, opacity: opacity) {
            self.init(color)
        } else {
            return nil
        }
    }
}

extension Color {
    init?(hex string: String, opacity: Double = 1.0) {
        // Remove the prefix
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let prefixFix: String
        if string.hasPrefix("0x") {
            prefixFix = String(string.dropFirst(2))
        } else if string.hasPrefix("#") {
            prefixFix = String(string.dropFirst(1))
        } else {
            prefixFix = string
        }

        let finalString: String
        switch prefixFix.count {
        case 3:
            finalString = prefixFix.reduce(into: "") { $0.append($1); $0.append($1) }
        case 6, 8:
            finalString = prefixFix
        default: return nil
        }
        
        let scanner = Scanner(string: finalString)
        var value: UInt64 = 0
        scanner.scanHexInt64(&value)
        if finalString.count == 6 {
            self.init(rgb: UInt32(value), opacity: opacity)
        } else {
            self.init(rgba: UInt32(value))
        }
    }
    
    /// Initialize a Color with the RGB hex value and alpha.
    /// - Parameters:
    ///   - rgbValue: A RGB hex value. For example, 0x0066cc.
    ///   - alpha: The transparency. The value of the alpha is from 0 to 1.
    /// - Returns: UIColor with the RGB hex value

    init(rgb: UInt32, opacity: CGFloat = 1) {
        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0xFF00) >> 8) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: opacity
        )
    }

    /// Initialize a UIColor with the RGBA hex value.
    ///
    /// - Parameter rgbaValue: A RGBA hex value. For example, 0x0066ccff.
    /// - Returns: UIColor with the RGBA hex value
    init(rgba: UInt32) {
        self.init(
            red: Double((rgba & 0xFF00_0000) >> 24) / 255.0,
            green: Double((rgba & 0xFF0000) >> 16) / 255.0,
            blue: Double((rgba & 0xFF00) >> 8) / 255.0,
            opacity: Double(rgba & 0xFF) / 255.0
        )
    }
}
