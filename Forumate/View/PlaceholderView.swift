//
//  PlaceholderView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct PlaceholderView: View {
    let text: String
    let image: String
    
    init(text: String, image: String = "doc.text.image") {
        self.text = text
        self.image = image
    }
    
    var body: some View {
        VStack {
            Image(systemName: image)
            Text(text)
                .padding()
        }
        .font(.title)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(text: "No Topic Selected")
    }
}
