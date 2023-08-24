//
//  PreviewContainer.swift
//  Forumate
//
//  Created by Kyle on 2023/6/10.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Community.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        container.mainContext.insert(Community.swift)
        return container
    } catch {
        fatalError("Failed to create preview container")
    }
}()
