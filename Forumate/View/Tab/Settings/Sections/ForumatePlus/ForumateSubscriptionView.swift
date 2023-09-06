//
//  ForumateSubscriptionView.swift
//  Forumate
//
//  Created by Kyle on 2023/9/7.
//

import StoreKit
import SwiftUI

struct ForumateSubscriptionView: View {    
    var body: some View {
        SubscriptionStoreView(groupID: "21353237", visibleRelationships: .all) {
            Image(.graph)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            #if os(iOS) || os(tvOS) || os(macOS)
                .containerBackground(for: .subscriptionStoreFullHeight) {
                    LinearGradient(colors: [.graph1, .graph2], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            #endif
        }
        .backgroundStyle(.clear)
        #if os(iOS) || os(visionOS) || os(macOS)
        .subscriptionStoreButtonLabel(.multiline)
        .storeButton(.visible, for: .redeemCode)
        #endif
        #if os(iOS) || os(visionOS) || os(watchOS) || os(macOS)
        .subscriptionStorePickerItemBackground(.ultraThinMaterial)
        #endif
        .storeButton(.visible, for: .restorePurchases)
    }
}

#Preview {
    ForumateSubscriptionView()
}
