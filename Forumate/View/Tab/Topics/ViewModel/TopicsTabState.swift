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
    @Published var columnVisibility: NavigationSplitViewVisibility = .automatic
}
