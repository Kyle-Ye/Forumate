//
//  ForumatePlusSection.swift
//  Forumate
//
//  Created by Kyle on 2023/6/19.
//

import StoreKit
import SwiftUI

struct ForumatePlusSection: View {
    @Environment(PlusManager.self) private var plusManager
    @State private var presentSubscription = false

    var body: some View {
        List {
            Section {
                if plusManager.plusEntitlement {
                    Text(verbatim: "✅")
                }
                if plusManager.lifeTimeEntitlement {
                    Label("You have a lifetime Forumate+ membership.", systemImage: "crown.fill")
                } else {
                    switch plusManager.subscriptionStatus {
                    case .notActive:
                        Text("You do not have any active Forumate+ subscription")
                    case .active:
                        Text("You have an active Forumate+ subscription. Thank you for your support.")
                    case .expired:
                        Text("Your Forumate+ subscription is expired")
                    }
                }
            }
            Section {
                Text("App Icon Replacement") + Text(verbatim: " *")
                Text("Theme Color Customization") + Text(verbatim: " *")
            } header: {
                Text("Exclusive features")
            } footer: {
                Text(verbatim: "* ") + Text("Only avaiable on supported platforms")
            }
            Section {
                Text("Forumate's most feature is free and its source code is avaiable on GitHub.")
                Text("You can support this project by becoming a Forumate+ Member via **Subscription Plan** or **Lifetime Plan**")
            }
            Section {
                NavigationLink {
                    ForumateSubscriptionView()
                } label: {
                    Text("Development Support Subscription")
                }
            } header: {
                Text("Subscription Plan")
            }
            if !plusManager.lifeTimeEntitlement {
                Section {
                    ProductView(id: "nonconsumable.pro_version") {
                        Image(systemName: "crown.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(Color.accentColor)
                    }
                } header: {
                    Text("Lifetime Plan")
                }
            }
        }
        .navigationTitle("Forumate+")
        .subscriptionStoreButtonLabel(.displayName)
    }
}

struct ForumatePlusSectionSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(PlusManager.self) private var plusManager

    var body: some View {
        NavigationStack {
            ForumatePlusSection()
            #if canImport(AppKit)
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark.circle.fill")
                    }
                }
            #endif
        }
        .onInAppPurchaseCompletion { product, result in
            if case let .success(.success(transaction)) = result {
                try? await plusManager.process(transaction)
                dismiss()
            }
        }
    }
}

#Preview {
    @State var plusManager = PlusManager()
    return NavigationStack {
        ForumatePlusSection()
    }
    .environment(plusManager)
}
