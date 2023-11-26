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
    static let groupID = "21353237"
    
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
    
    init() {
        updateListenerTask = listenForTransactions()
    }
    
    func process(_ result: VerificationResult<Transaction>) async throws {
        do {
            let transaction = try self.checkVerified(result)
            await self.updatePurchasedIdentifiers(transaction)
            await transaction.finish()
        } catch {
            print("Transaction failed verification")
        }
    }
    
    @ObservationIgnored
    private var updateListenerTask: Task<Void, any Error>?
    
    private func listenForTransactions() -> Task<Void, any Error> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                try await self?.process(result)
            }
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case let .verified(safe):
            safe
        }
    }
    
    @MainActor
    private func updatePurchasedIdentifiers(_ transaction: Transaction) {
        if let subscriptionGroupID = transaction.subscriptionGroupID {
            // Auto renew purchase
            guard subscriptionGroupID == PlusManager.groupID,
                  let expirationDate = transaction.expirationDate
            else { return }
            if transaction.revocationDate != nil {
                subscriptionStatus = .notActive
            } else if expirationDate > Date.now {
                subscriptionStatus = .active
            } else {
                subscriptionStatus = .expired
            }
        } else {
            // Other purchase
            if transaction.revocationDate == nil {
                lifeTimeEntitlement = true
            } else {
                lifeTimeEntitlement = false
            }
        }
    }
}

enum StoreError: Error {
    case failedVerification
}

enum PlusError: LocalizedError {
    case plusOnlyFeature
    
    var errorDescription: String? {
        switch self {
        case .plusOnlyFeature: 
            String(localized: "You need an active Forumate+ membership to unlock this feature.", comment: "Plus only feature Description")
        }
    }
}
