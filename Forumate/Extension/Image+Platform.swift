//
//  Image+Platform.swift
//  Forumate
//
//  Created by Kyle on 2023/9/1.
//

import SwiftUI

extension Image {
    init(platformNamed name: String) {
        #if os(macOS)
        self.init(nsImage: NSImage(named: name) ?? NSImage())
        #else
        self.init(uiImage: UIImage(named: name) ?? UIImage())
        #endif
    }
}
