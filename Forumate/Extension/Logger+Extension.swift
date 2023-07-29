//
//  Logger+Extension.swift
//  Forumate
//
//  Created by Kyle on 2023/7/29.
//

import OSLog

extension Logger {
    static var subsystem = Bundle.main.bundleIdentifier ?? ""
}
