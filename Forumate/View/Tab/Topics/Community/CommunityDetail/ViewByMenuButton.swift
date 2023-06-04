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
        #if os(iOS) || os(macOS)
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
        #else
        Picker(selection: $state.viewByType) {
            ForEach(CommunityDetailState.ViewByType.allCases, id: \.rawValue) { type in
                Text(type.rawValue.capitalized).tag(type)
            }
        } label: {
            Label {
                Text("View By Type")
            } icon: {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .symbolRenderingMode(.hierarchical)
            }
        }
        .pickerStyle(.navigationLink)
        #endif
    }
}

struct ViewByMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        ViewByMenuButton()
            .environmentObject(CommunityDetailState(community: .swift))
    }
}
