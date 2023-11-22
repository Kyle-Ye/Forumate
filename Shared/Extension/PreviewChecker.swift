//
//  PreviewChecker.swift
//  Forumate
//
//  Created by Kyle on 2023/6/2.
//

import Foundation

#if DEBUG
enum PreviewChecker {
    static let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
#endif
