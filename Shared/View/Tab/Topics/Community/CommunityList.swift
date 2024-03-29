//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftData
import SwiftUI

struct CommunityList: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: TopicsTabState
    @Environment(\.modelContext) private var modelContext
    @Query(
        sort: [SortDescriptor<Community>(\.sortIndex)],
        animation: .spring
    )
    private var communities: [Community]

    private var hasPinnedCommunity: Bool {
        communities.contains { $0.pin && (searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)) }
    }

    private var pinnedCommunities: [Community] {
        communities.filter { $0.pin && (searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)) }
    }

    private var hasUnpinnedCommunity: Bool {
        communities.contains { !$0.pin && (searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)) }
    }

    private var unpinnedCommunities: [Community] {
        communities.filter { !$0.pin && (searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)) }
    }

    private var hasRecommendCommunity: Bool {
        [RecommendCommunity].recommended.contains { recommendCommunity in
            communities.allSatisfy { community in
                community.host != recommendCommunity.host
            } && (searchText.isEmpty || recommendCommunity.title.localizedCaseInsensitiveContains(searchText))
        }
    }

    private var recommendCommunities: [RecommendCommunity] {
        [RecommendCommunity].recommended.filter { recommendCommunity in
            communities.allSatisfy { community in
                community.host != recommendCommunity.host
            } && (searchText.isEmpty || recommendCommunity.title.localizedCaseInsensitiveContains(searchText))
        }
    }
    
    @AppStorage(ShowRecommendCommunity.self)
    private var showRecommendCommunity

    @State private var searchText = ""
    #if !os(watchOS)
    @State private var isSearching = false
    #endif
    var body: some View {
        List(selection: $tabState.selectedCommunity) {
            if hasPinnedCommunity {
                pinnedCommunityList
            }
            if hasUnpinnedCommunity {
                unpinnedCommunityList
            }
            if showRecommendCommunity, hasRecommendCommunity {
                recommendCommunityList
            }
        }
        #if os(watchOS) || os(tvOS)
        .searchable(text: $searchText)
        #else
        .searchable(text: $searchText, isPresented: $isSearching, placement: .sidebar)
        .onChange(of: searchText) { _, newValue in
            isSearching = !newValue.isEmpty
        }
        #endif
    }

    var pinnedCommunityList: some View {
        Section {
            ForEach(pinnedCommunities) { community in
                CommunityItem(community: community)
            }
            .onDelete(perform: deleteCommunities(at:))
            .onMove(perform: movePinnedCommunities(from:to:))
        } header: {
            Text("Pinned Communities")
        }
    }

    var unpinnedCommunityList: some View {
        Section {
            ForEach(unpinnedCommunities) { community in
                CommunityItem(community: community)
            }
            .onDelete(perform: deleteCommunities(at:))
            .onMove(perform: moveUnpinnedCommunities(from:to:))
        } header: {
            Text("My Communities")
        }
    }

    var recommendCommunityList: some View {
        Section {
            ForEach(recommendCommunities) { recommendCommunity in
                RecommendCommunityLabel(recommendCommunity: recommendCommunity)
            }
        } header: {
            Text("Recommended Communities")
        }
    }

    private struct CommunityItem: View {
        @Environment(\.modelContext) private var modelContext

        var community: Community
        var body: some View {
            NavigationLink(value: community) {
                CommunityLabel(community: community)
            }
            #if !os(tvOS)
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    modelContext.delete(community)
                } label: {
                    Label("Delete", systemImage: "trash")
                }.tint(.red)
            }
            .swipeActions(edge: .leading) {
                Button {
                    community.pin.toggle()
                } label: {
                    Label(
                        community.pin ? "Unpin" : "Pin",
                        systemImage: community.pin ? "pin.slash.fill" : "pin.fill"
                    )
                }.tint(.orange)
            }
            #endif
        }
    }

    private func deleteCommunities(at _: IndexSet) {}

    private func movePinnedCommunities(from indices: IndexSet, to newOffset: Int) {
        var communities = pinnedCommunities
        communities.move(fromOffsets: indices, toOffset: newOffset)
        communities.enumerated().forEach { $0.element.sortIndex = $0.offset }
    }

    private func moveUnpinnedCommunities(from indices: IndexSet, to newOffset: Int) {
        var communities = unpinnedCommunities
        communities.move(fromOffsets: indices, toOffset: newOffset)
        communities.enumerated().forEach { $0.element.sortIndex = $0.offset }
    }
}

#Preview {
    NavigationStack {
        CommunityList()
            .navigationTitle("Forumate")
    }
    .environmentObject(AppState())
    .environmentObject(TopicsTabState())
    .modelContainer(previewContainer)
}
