//
//  AppState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/8.
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    // TODO: Use Local storage to store community info temportary. Will use CoreData to add iCloud sync Support
    @AppStorage("communities") private(set) var communities: [Community] = [.swift]
    
    func addCommunity(_ community: Community) {
        communities.append(community)
    }
}
