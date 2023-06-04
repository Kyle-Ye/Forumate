//
//  File.swift
//
//
//  Created by Yanis Plumit on 05.02.2023.
//

import SwiftUI

extension Color {
    public func toHex(alpha: Bool = false) -> String? {
        UIColor(self).toHex(alpha: alpha)
    }
}

extension UIColor {
    public func toHex(alpha: Bool = false) -> String? {
        guard let components = self.cgColor.components, components.count >= 2 else {
            return nil
        }
        
        let r = Float(components.count >= 3 ? components[0] : components[0])
        let g = Float(components.count >= 3 ? components[1] : components[0])
        let b = Float(components.count >= 3 ? components[2] : components[0])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
