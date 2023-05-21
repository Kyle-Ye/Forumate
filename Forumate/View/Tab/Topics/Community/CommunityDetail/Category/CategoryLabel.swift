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
            if let description = category.description {
                Text(LocalizedStringKey(description.replacingHTMLLink()))
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

struct CategoryLabel_Previews: PreviewProvider {
    static var announcements: Category {
        let decoder = JSONDecoder()
        let data = #"""
        {
            "id": 24,
            "name": "Announcements",
            "color": "231F20",
            "position": 0,
            "description": "General announcements related to the Swift project and Swift releases.",
            "description_text": "General announcements related to the Swift project and Swift releases.",
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Category.self, from: data)
    }
    
    static var evolution: Category {
        let decoder = JSONDecoder()
        let data = #"""
        {
            "id": 18,
            "name": "Evolution",
            "color": "BF1E2E",
            "position": 1,
            "description": "Topics related to the <a href=\"https://github.com/apple/swift-evolution/blob/main/process.md\">Swift Evolution Process</a>.",
            "description_text": "Topics related to the Swift Evolution Process.",
        }
        """#.data(using: .utf8)!
        return try! decoder.decode(Category.self, from: data)
    }
     
    static var previews: some View {
        List {
            CategoryLabel(category: announcements)
            CategoryLabel(category: evolution)
        }
    }
}
