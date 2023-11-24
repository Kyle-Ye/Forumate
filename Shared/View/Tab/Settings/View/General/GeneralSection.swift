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
    
    #if os(iOS) || os(watchOS) || os(macOS) || os(visionOS)
    @AppStorage(SplitViewStyleTypeSetting.self)
    private var navigationSplitViewStyle
    #endif

    @AppStorage(PickerStyleTypeSetting.self)
    private var pickerStyle

    #if os(iOS) || os(visionOS)
    @AppStorage(OpenLinkTypeSetting.self)
    private var openLinkType
    #endif
    
    @AppStorage(ShowRecommendCommunity.self)
    private var showRecommendCommunity
    
    #if os(macOS)
    @AppStorage(ShowMenuBarExtra.self)
    private var showMenuBarExtra
    #endif

    var body: some View {
        Form {
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
                #if os(iOS) || os(watchOS) || os(macOS) || os(visionOS)
                Picker("Navigation Split View Style", selection: $navigationSplitViewStyle) {
                    ForEach(SplitViewStyleType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                #endif
                Picker("Picker Style", selection: $pickerStyle) {
                    ForEach(PickerStyleType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            } header: {
                Text("System UI Style")
            } footer: {
                #if os(macOS)
                EmptyView()
                #else
                VStack(alignment: .leading) {
                    Text("Navigation Split View Style is used in Tabs")
                    Text("Picker Style is used in Settings tab")
                }
                #endif
            }
            Section {
                #if os(iOS) || os(visionOS)
                Picker("Open Link In", selection: $openLinkType) {
                    ForEach(OpenLinkType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                #endif
                Toggle(isOn: $showRecommendCommunity) {
                    Text("Show Recommend Communities")
                }
                #if os(macOS)
                Toggle(isOn: $showMenuBarExtra) {
                    Text("Show ForumateHelper in Menu Bar")
                }
                #endif
            } header: {
                Text("Other")
            }
            #if !os(tvOS)
            .controlSize(.large)
            #endif
        }
        .formStyle(.grouped)
        .pickerStyleType(PickerStyleTypeSetting.value)
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
