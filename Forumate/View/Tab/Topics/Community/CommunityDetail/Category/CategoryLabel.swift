//
//  CategoryLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CategoryLabel: View {
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let color = Color(hex: category.color) {
                    color.frame(width: 10, height: 10)
                }
                Text(category.name)
            }
            if let descriptionText = category.descriptionText {
                Text(descriptionText)
                    .foregroundColor(.secondary)
            }
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 10))]) {
                ForEach(category.subcategoryIDs, id: \.self) { id in
                    SubcategoryLabel(id: id)
                }
            }
        }
    }
}

// struct CategoryLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryLabel(category: <#T##Category#>)
//    }
// }
