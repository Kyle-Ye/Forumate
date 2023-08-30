//
//  TopicsTabState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import Foundation
import SwiftUI
import Combine

class TopicsTabState: ObservableObject {
    @Published var selectedCommunity: Community?
    @Published var selectedCategories: [Category] = []
    @Published var selectedTopic: Topic?
    #if os(visionOS)
    @Published var columnVisibility: NavigationSplitViewVisibility = .all
    #else
    @Published var columnVisibility: NavigationSplitViewVisibility = .automatic
    #endif
    @Published var column: NavigationSplitViewColumn = .sidebar
}
