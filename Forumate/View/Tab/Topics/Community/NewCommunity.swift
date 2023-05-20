//
//  NewCommunity.swift
//  Forumate
//
//  Created by Kyle on 2023/4/20.
//

import SwiftUI

struct NewCommunity: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState

    @State private var urlInput = ""
    
    private var url: URL? { URL(string: urlInput) }
    
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
                    Text("Add New Community")
                } footer: {
                    Text("Forumate only supports communities built using the Discourse platform and running HTTPS. Please consult the support page for help regarding supported communities.")
                }
            }
            .submitLabel(.send)
            .onSubmit { tryAddCommunity() }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") { tryAddCommunity() }
                        .buttonStyle(.bordered)
                        .disabled(url == nil)
                }
            }
        }
    }
    
    @MainActor
    private func tryAddCommunity() {
        guard let url,
              let community = try? Community(host: url)
        else { return }
        appState.addCommunity(community)
        dismiss()
    }
}

struct NewCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommunity()
    }
}
