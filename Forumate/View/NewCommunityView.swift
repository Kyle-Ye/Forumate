//
//  NewCommunityView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/20.
//

import SwiftUI

struct NewCommunityView: View {
    @State private var urlInput = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Community URL",
                        text: $urlInput,
                        prompt: Text("Example: forums.example.com")
                    )
                } header: {
                    Text("1")
                } footer: {
                    Text("1")
                }
            }
        }
    }
}

struct NewCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommunityView()
    }
}
