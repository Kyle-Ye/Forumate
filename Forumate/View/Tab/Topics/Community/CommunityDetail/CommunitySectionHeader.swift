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
        HStack {
            Text(text)
                .foregroundColor(.primary)
                .bold()
                .font(.headline)
                .padding(.vertical)
        }
    }
}

struct CommunitySectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Section {
                    Text("Hello")
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
