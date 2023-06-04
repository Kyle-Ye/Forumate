//
//  GeneralSection.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI

struct GeneralSection: View {
    @AppStorage(DefaultViewByTypeSetting.self) var defaultViewByType
    @AppStorage(SplitViewStyleTypeSetting.self) var navigationSplitViewStyle
    @AppStorage(PickerStyleTypeSetting.self) var pickerStyle

    #if os(iOS)
    @AppStorage(OpenLinkTypeSetting.self) var openLinkType
    #endif

    var body: some View {
        List {
            Section {
                Picker("Default View By Type", selection: $defaultViewByType) {
                    ForEach(CommunityDetailState.ViewByType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
            } header: {
                Text("Community Setting")
            }
            Section {
                Picker("Navigation Split View Style", selection: $navigationSplitViewStyle) {
                    ForEach(SplitViewStyleType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                Picker("Picker Style", selection: $pickerStyle) {
                    ForEach(PickerStyleType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            } header: {
                Text("System UI Style")
            } footer: {
                VStack(alignment: .leading) {
                    Text("Navigation Split View Style is used in Tabs")
                    Text("Picker Style is used in Settings tab")
                }
            }
            #if os(iOS)
            Section {
                Picker("Open Link In", selection: $openLinkType) {
                    ForEach(OpenLinkType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            } header: {
                Text("Other")
            }
            #endif
        }
        .pickerStyleType(PickerStyleTypeSetting.value)
        #if os(iOS)
            .listStyle(.insetGrouped)
        #endif
    }
}

struct GeneralSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GeneralSection()
                .navigationTitle("General")
            #if os(iOS) || os(watchOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}
