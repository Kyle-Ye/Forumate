//
//  CategoryDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CategoryDetail: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
    }
}

//struct CategoryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetail()
//    }
//}
