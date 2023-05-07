//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

struct CommunityList: View {
    @EnvironmentObject var appState: AppState
    @State private var presentNewCommunityView = false
    
    var body: some View {
        List {
            Section {
                ForEach(appState.communities) { community in
                    Text(community.name)
                }
            } header: {
                Text("My Communities")
            }
        }
        .navigationTitle("Communities")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    presentNewCommunityView = true
                } label: {
                    Label("Add Community", systemImage: "plus.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
                .sheet(isPresented: $presentNewCommunityView) {
                    NewCommunityView()
                }
            }
        }
        

    }
}

struct CommunityList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityList()
        }
    }
}
