//
//  SubcategoryLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct SubcategoryLabel: View {
    let category: Category

    var body: some View {
        (
            category.color.colorToImageText(image: "square.fill")
                + Text("\(category.name)")
        )
        .lineLimit(1)
        .foregroundColor(.secondary)
        .font(.caption)
    }
}

struct SubcategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubcategoryLabel(category: .announcements)
            SubcategoryLabel(category: .evolution)
        }
    }
}
