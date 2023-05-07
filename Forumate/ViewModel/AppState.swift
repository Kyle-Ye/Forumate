//
//  AppState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/8.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    /// TODO: Use Local storage to store community info temportary. Will use CoreData to add iCloud sync Support
    @Published private(set) var communities: [Community] = [.swift]
    
    func addCommunity(_ community: Community) {
        // TODO: 去重
        communities.append(community)
    }
}
