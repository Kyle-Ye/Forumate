//
//  CommunitySectionHeader.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct CommunitySectionHeader: View {
    let text: String
    let showButton: Bool
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.primary)
                .bold()
                .font(.headline)
                .padding(.vertical)
            Spacer()
            #if !os(watchOS)
            ViewByMenuButton().opacity(showButton ? 1.0 : 0.0)
            #endif
        }
    }
}

struct CommunitySectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                Text("Hello")
            } header: {
                CommunitySectionHeader(text: "Categories", showButton: true)
            }
        }
        .listStyle(.plain)
        
    }
}
