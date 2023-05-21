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
        HStack {
            if let color = Color(hex: category.color) {
                color.frame(width: 10, height: 10)
            }
            Text(category.name)
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
    }
}

struct SubcategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        SubcategoryLabel(category: .announcements)
    }
}
