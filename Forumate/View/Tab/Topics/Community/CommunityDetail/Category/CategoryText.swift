//
//  CategoryText.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CategoryText: View {
    let category: Category

    var body: Text {
        category.color.colorToImageText(image: "square.fill")
            + Text("\(category.name)")
    }
}

struct CategoryText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryText(category: .announcements)
            CategoryText(category: .evolution)
        }
    }
}
