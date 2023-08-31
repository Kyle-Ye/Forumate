//
//  RecommendCommunityLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import SwiftData
import SwiftUI

struct RecommendCommunityLabel: View {
    let name: String
    let url: URL
    
    @Environment(\.modelContext) private var context
    @State private var loading = false
    @State private var loadingError = false
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Button {
                Task {
                    loadingError = false
                    loading = true
                    do {
                        let community = try await CommunityManager.shared.createCommunity(url)
                        context.insert(community)
                    } catch {
                        loadingError = true
                    }
                    loading = false
                }
            } label: {
                if loadingError {
                    Image(systemName: "exclamationmark.circle.fill")
                } else if loading {
                    ProgressView()
                } else {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

struct RecommendCommunityLabel_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecommendCommunityLabel(name: "Swift Forums", url: URL(string: "https://forums.swift.org")!)
        }
        .modelContainer(previewContainer)
    }
}
