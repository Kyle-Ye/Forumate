//
//  TagView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/23.
//

import SwiftUI

struct TagView: View {
    init(_ tag: String) {
        self.tag = tag
    }
    
    let tag: String
    
    var body: some View {
        Text(tag)
            .font(.caption)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .foregroundStyle(.secondary)
            #if !os(watchOS)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 5))
            #endif
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TagView("swift-docc")
            TagView("swift-docc")
                .environment(\.colorScheme, .dark)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            VStack {
                Color.white
                Color.black
            }
        }
    }
}
