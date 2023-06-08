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
            return Text("\(Image(systemName: image)) ").foregroundColor(color)
        } else {
            return Text("")
        }
    }
}


struct ColorToImageText_Previews: PreviewProvider {
    static var previews: some View {
        "AAA".colorToImageText(image: "square.fill") + Text(verbatim: "Hello")
    }
}
