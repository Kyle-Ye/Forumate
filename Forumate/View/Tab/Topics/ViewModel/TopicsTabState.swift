//
//  TopicsTabState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import Foundation
import DiscourseKit
import SwiftUI

class TopicsTabState: ObservableObject {
    @Published var selectedCommunity: Community?
    @Published var selectedTopic: Topic?
    
    #if os(iOS) || os(macOS) || os(tvOS)
    @Published var columnVisibility: NavigationSplitViewVisibility = .automatic
    #endif
}
