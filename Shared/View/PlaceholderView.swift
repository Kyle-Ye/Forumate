//
//  PlaceholderView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct PlaceholderView: View {
    let text: LocalizedStringKey
    let image: String
    
    init(text: LocalizedStringKey, image: String = "doc.text.image") {
        self.text = text
        self.image = image
    }
    
    var body: some View {
        ContentUnavailableView(text, systemImage: image)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(text: "No Topic Selected")
    }
}
