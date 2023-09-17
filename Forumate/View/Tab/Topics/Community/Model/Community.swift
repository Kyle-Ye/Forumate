//
//  Community
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import Foundation
import SwiftData

@Model
final class Community {
    private(set) var id = UUID()
    private(set) var host: URL!
    private(set) var title = ""
    private(set) var icon: URL?
    
    /// Pinned by user
    var pin = false
    
    /// Sort Index
    var sortIndex = 0
    
    init(host: URL, title: String = "", icon: URL? = nil) {
        self.host = host
        self.title = title
        self.icon = icon
    }
}
