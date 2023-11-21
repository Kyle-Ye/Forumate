//
//  ColorToImageText.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import SwiftUI

extension String {
    func colorToImageText(image: String) -> Text {
        if let color = Color(hex: self) {
            return Text("\(Image(systemName: image))").foregroundStyle(color) + Text(" ")
        } else {
            return Text("")
        }
    }
}

#Preview {
    "AAA".colorToImageText(image: "square.fill") + Text(verbatim: "Hello")
}
