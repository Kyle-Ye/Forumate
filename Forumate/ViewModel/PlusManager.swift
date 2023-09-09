//
//  PlusManager.swift
//  Forumate
//
//  Created by Kyle on 2023/9/9.
//

import Foundation
import Observation
import StoreKit

/// ForumatePlus memebership manager of the app
@Observable
class PlusManager {
    enum SubscriptionStatus {
        case notActive
        case active
        case expired
    }
    
    var subscriptionStatus: SubscriptionStatus = .notActive
    var lifeTimeEntitlement = false
    
    var plusEntitlement: Bool {
        subscriptionStatus == .active || lifeTimeEntitlement
    }
}

enum PlusError: LocalizedError {
    case plusOnlyFeature
    
    var errorDescription: String? {
        switch self {
        case .plusOnlyFeature: "You need a valid Forumte+ membership to unlock this feature."
        }
    }
}
