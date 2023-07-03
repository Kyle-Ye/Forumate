//
//  SubscriptionSection.swift
//  Forumate
//
//  Created by Kyle on 2023/6/19.
//

import StoreKit
import SwiftUI

struct SubscriptionSection: View {
    var body: some View {
        TabView {
            ProductView(id: "nonconsumable.pro_version", prefersPromotionalIcon: true) {
                AppIcon()
                    .clipShape(Circle())
            }
            SubscriptionStoreView(groupID: "21353237")
        }
        #if os(watchOS)
        .tabViewStyle(.verticalPage(transitionStyle: .identity))
        #elseif !os(macOS)
        .tabViewStyle(.page)
        #endif
    }
}

#Preview {
    SubscriptionSection()
}
