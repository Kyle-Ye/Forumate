//
//  GeneralSection.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI
#if !os(watchOS)
import HtmlText
#endif

enum OpenLinkStyle: String, Hashable, CaseIterable {
    case modal = "In-App Safari"
    case safari = "Safari App"
    
    static var unspecified: OpenLinkStyle { modal }
}

struct GeneralSection: View {
    @AppStorage(SettingKeys.defaultViewByType) var defaultViewByType: CommunityDetailState.ViewByType = .categories

    #if !os(watchOS)
    @AppStorage(SettingKeys.openLinkStyle) var openLinkStyle: OpenLinkStyle = .unspecified
    #endif

    var body: some View {
        List {
            Section {
                Picker("Default View By Type", selection: $defaultViewByType) {
                    ForEach(CommunityDetailState.ViewByType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                #if !os(watchOS)
                Picker("Open Link In", selection: $openLinkStyle) {
                    ForEach(OpenLinkStyle.allCases, id: \.rawValue) { style in
                        Text(style.rawValue).tag(style)
                    }
                }
                #endif
            } header: {
                Text("Other")
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct GeneralSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GeneralSection()
                .navigationTitle("General")
            #if !os(tvOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}
