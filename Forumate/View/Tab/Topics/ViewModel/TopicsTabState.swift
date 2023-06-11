//
//  TopicsTabState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import Foundation
import SwiftUI

class TopicsTabState: ObservableObject {
    @Published var selectedCommunity: Community?
    @Published var navigationPath: NavigationPath = .init()
    @Published var selectedTopic: Topic?
    @Published var columnVisibility: NavigationSplitViewVisibility = .automatic
}
