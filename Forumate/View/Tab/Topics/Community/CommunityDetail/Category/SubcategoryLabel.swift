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
        #if os(tvOS)
        let spacing = 20.0
        #else
        let spacing: CGFloat? = nil
        #endif
        HStack(spacing: spacing) {
            if let color = Color(hex: category.color) {
                color
                #if os(tvOS)
                .frame(width: 20, height: 20)
                #else
                .frame(width: 10, height: 10)
                #endif
            }
            Text(category.name)
                .lineLimit(1)
                .foregroundColor(.secondary)
                .font(.caption)
        }
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
