//
//  CommunitySectionHeader.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct CommunitySectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .bold()
            .font(.headline)
            .padding(.vertical)
            .foregroundStyle(.primary)
    }
}

struct CommunitySectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Section {
                    Text(verbatim: "Hello")
                } header: {
                    CommunitySectionHeader(text: "Categories")
                }
            }
            .listStyle(.plain)
            .toolbar {
                ViewByMenuButton()
            }
        }
        .environmentObject(CommunityDetailState(community: .swift))
    }
}
