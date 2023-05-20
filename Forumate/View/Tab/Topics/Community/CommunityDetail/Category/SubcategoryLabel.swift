//
//  SubcategoryLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct SubcategoryLabel: View {
    init(id _: Int) {
        color = ""
        name = ""
    }
    
    private let color: String
    private let name: String
    
    var body: some View {
        Group {
            if let color = Color(hex: color) {
                color
            }
            Text(name)
                .bold()
                .foregroundColor(.secondary)
        }
    }
}

// struct SubcategoryLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        SubcategoryLabel()
//    }
// }
