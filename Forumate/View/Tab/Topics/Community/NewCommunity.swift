//
//  NewCommunity.swift
//  Forumate
//
//  Created by Kyle on 2023/4/20.
//

import DiscourseKit
import os.log
import SwiftUI

struct NewCommunity: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState

    @State private var urlInput = ""
    @State private var loading = false
    @State private var loadingError = false

    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "NewCommunity")
    
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
            #if !os(watchOS)
                .toolbar {
                    #if os(iOS)
                    let cancelPlacement: ToolbarItemPlacement = .navigationBarLeading
                    let conformPlacement: ToolbarItemPlacement = .navigationBarTrailing
                    #else
                    let cancelPlacement: ToolbarItemPlacement = .cancellationAction
                    let conformPlacement: ToolbarItemPlacement = .confirmationAction
                    #endif
                    ToolbarItem(placement: cancelPlacement) {
                        Button("Cancel") { dismiss() }
                            .buttonStyle(.bordered)
                    }
                    ToolbarItem(placement: conformPlacement) {
                        Group {
                            if loading {
                                ProgressView()
                            } else {
                                Button("Add") { tryAddCommunity() }
                                    .buttonStyle(.bordered)
                                    .disabled(url == nil)
                            }
                        }
                        .alert("Could not add community", isPresented: $loadingError) {
                            Button(role: .cancel) {
                                NewCommunity.logger.info("Failed to add community for \(urlInput)")
                            } label: {
                                Text("OK")
                            }
                        } message: {
                            Text("The community provided does not like a Discourse community.")
                        }
                    }
                }
            #endif
        }
    }
    
    @MainActor
    private func tryAddCommunity() {
        guard let url else { return }
        loading = true
        Task.detached {
            let client = Client(baseURL: url)
            do {
                let info = try await client.fetchSiteBasicInfo()
                let community = Community(host: url, title: info.title, icon: info.appleTouchIconURL)
                await MainActor.run {
                    appState.addCommunity(community)
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    loadingError = true
                }
            }
            await MainActor.run {
                loading = false
            }
        }
    }
}

struct NewCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommunity()
            .environmentObject(AppState())
    }
}
