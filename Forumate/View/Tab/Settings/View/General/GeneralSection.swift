//
//  GeneralSection.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI

struct GeneralSection: View {
    @AppStorage(DefaultViewByTypeSetting.self)
    private var defaultViewByType
    
    @AppStorage(SplitViewStyleTypeSetting.self)
    private var navigationSplitViewStyle
    
    @AppStorage(PickerStyleTypeSetting.self)
    private var pickerStyle

    #if os(iOS) || os(visionOS)
    @AppStorage(OpenLinkTypeSetting.self)
    private var openLinkType
    #endif
    
    @AppStorage(ShowRecommendCommunity.self)
    private var showRecommendCommunity

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
            #if os(iOS) || os(visionOS)
            Section {
                Picker("Open Link In", selection: $openLinkType) {
                    ForEach(OpenLinkType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                Toggle(isOn: $showRecommendCommunity) {
                    Text("Show Recommend Communities")
                }
            } header: {
                Text("Other")
            }
            #endif
        }
        .pickerStyleType(PickerStyleTypeSetting.value)
        #if os(iOS) || os(visionOS)
            .listStyle(.insetGrouped)
        #endif
    }
}

#Preview {
    NavigationStack {
        GeneralSection()
            .navigationTitle("General")
        #if os(iOS) || os(visionOS) || os(watchOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}