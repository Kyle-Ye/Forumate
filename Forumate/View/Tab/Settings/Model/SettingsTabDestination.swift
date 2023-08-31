//
//  SettingsTabDestination.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import Foundation
import SwiftUI

struct SettingsTabDestination: Hashable {
    enum ID {
        case subscription
        #if os(iOS) || os(visionOS) || os(tvOS) || os(macOS)
        case iconSelector
        #endif
        case general
        case notification
        case support
        case privacy
        case acknowledgement
    }
    
    let title: LocalizedStringKey
    let id: ID
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
