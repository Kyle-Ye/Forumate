//
//  File.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import Foundation

class TopicsTabState: ObservableObject {
    @Published var selectedCommunity: Community?
    
    enum ViewByType: String {
        case categories
        case latest
        case top
        case new
        case unread
        case bookmard
    }
    
    @Published var viewByType: ViewByType = .categories

    // @Published var selectedCategory
}
