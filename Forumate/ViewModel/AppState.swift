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
    @AppStorage("is_first_launch") private var _isFirstLaunch = true
    var isFirstLaunch: Bool { _isFirstLaunch }
    
    @AppStorage("has_showed_starter_intro") private var _hasShowedStarterIntro = false
    var hasShowedStarterIntro: Bool { _hasShowedStarterIntro }
    
    // TODO: Migrate to use CoreData or others to add iCloud sync Support
    @AppStorage("communities") private var _communities: [Community] = [.swift]
    var communities: [Community] { _communities }
    
    func didFirstLaunch() {
        _isFirstLaunch = true
        _hasShowedStarterIntro = true
    }
    
    func addCommunity(_ community: Community) {
        _communities.append(community)
    }
}
