//
//  SettingsTabState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

// FIXME: If we change this to use Observable Macro, we'll get a stable crash.
class SettingsTabState: ObservableObject {
    @Published var destination: SettingsTabDestination?
}
