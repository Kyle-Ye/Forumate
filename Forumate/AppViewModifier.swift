//
//  AppViewModifier.swift
//  Forumate
//
//  Created by Kyle on 2023/9/9.
//

import SwiftUI

struct AppViewModifier: ViewModifier {
    @EnvironmentObject
    private var appState: AppState
    #if os(iOS) || os(macOS)
    @Environment(ThemeManager.self)
    private var themeManager
    #endif
    @Environment(PlusManager.self)
    private var plusManager

    func body(content: Content) -> some View {
        content
            .environmentObject(appState)
        #if os(iOS) || os(macOS)
            .preferredColorScheme(themeManager.colorScheme)
            .tint(themeManager.accentColor)
        #endif
            .currentEntitlementTask(for: "nonconsumable.pro_version") { taskState in
                if let value = taskState.value, let value {
                    guard case let .verified(transaction) = value
                    else { return }
                    await transaction.finish()
                    plusManager.lifeTimeEntitlement = true
                }
            }
            .subscriptionStatusTask(for: "21353237") { taskState in
                if let value = taskState.value {
                    for status in value {
                        guard case let .verified(_) = status.transaction
                        else { break }
                        switch status.state {
                        case .subscribed, .inGracePeriod, .inBillingRetryPeriod:
                            plusManager.subscriptionStatus = .active
                        case .expired, .revoked:
                            plusManager.subscriptionStatus = .expired
                        default:
                            plusManager.subscriptionStatus = .notActive
                        }
                    }
                }
            }
    }
}
