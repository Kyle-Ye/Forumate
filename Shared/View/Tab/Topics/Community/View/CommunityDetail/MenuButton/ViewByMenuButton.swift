//
//  ViewByMenuButton.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct ViewByMenuButton: View {
    @EnvironmentObject private var state: CommunityDetailState

    var body: some View {
        #if os(iOS) || os(visionOS) || os(macOS) || os(tvOS)
        Menu {
            Picker(selection: $state.viewByType) {
                ForEach(CommunityDetailState.ViewByType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            } label: {
                Text("View By Type")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        #elseif os(watchOS)
        Picker(selection: $state.viewByType) {
            ForEach(CommunityDetailState.ViewByType.allCases, id: \.rawValue) { type in
                Text(type.rawValue.capitalized).tag(type)
            }
        } label: {
            Label {
                Text("View By Type")
            } icon: {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
            }
        }
        .pickerStyle(.navigationLink)
        #else
        EmptyView()
        #endif
    }
}

#Preview {
    ViewByMenuButton()
        .buttonStyle(.borderedProminent)
        .environmentObject(CommunityDetailState(community: .swift))
}
