//
//  SettingsTabState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation
import Observation
import SwiftUI

class SettingsTabState: ObservableObject {
    @Published var destination: SettingsTabDestination? = nil
}
