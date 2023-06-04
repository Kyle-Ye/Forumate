//
//  SplitViewStyleType.swift
//  Forumate
//
//  Created by Kyle on 2023/6/4.
//

import Foundation
import SwiftUI

enum SplitViewStyleType: String, Hashable, CaseIterable {
    case automatic = "Automatic"
    case balanced = "Balanced"
    case prominentDetail = "Prominent Detail"
}

extension SplitViewStyleType: Unspecifiable {
    static var unspecified: SplitViewStyleType { automatic }
}

enum SplitViewStyleTypeSetting: Setting {
    typealias Value = SplitViewStyleType
    static var key: String { "split_view_style_type" }
}

extension View {
    @ViewBuilder
    func navigationSplitViewStyleType(_ type: SplitViewStyleType) -> some View {
        switch type {
        case .automatic: navigationSplitViewStyle(.automatic)
        case .balanced: navigationSplitViewStyle(.balanced)
        case .prominentDetail: navigationSplitViewStyle(.prominentDetail)
        }
    }
}
