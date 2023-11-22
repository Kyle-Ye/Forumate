//
//  RecommendCommunityLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import SwiftData
import SwiftUI

struct RecommendCommunityLabel: View {    
    let recommendCommunity: RecommendCommunity
    
    @Environment(\.modelContext) private var context
    @State private var loading = false
    @State private var loadingError = false
    
    var body: some View {
        HStack {
            Text(recommendCommunity.title)
            Spacer()
            Button {
                Task {
                    loadingError = false
                    loading = true
                    do {
                        let community = try await CommunityManager.shared.createCommunity(recommendCommunity.host)
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

#Preview {
    List([RecommendCommunity].recommended) {
        RecommendCommunityLabel(recommendCommunity: $0)
    }
    .modelContainer(previewContainer)

}
