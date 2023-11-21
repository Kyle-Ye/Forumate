//
//  AppInfo.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation
#if os(iOS) || os(visionOS) || os(tvOS) || os(visionOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

enum AppInfo {
    static var name: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
    
    static var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    static var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }

    static var starterIntroVersion: Int { 1 }
    
    static var OSVersion: String {
        #if (os(iOS) && !targetEnvironment(macCatalyst)) || os(tvOS) || os(visionOS)
        UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        #elseif os(watchOS)
        WKInterfaceDevice.current().systemName + " " + WKInterfaceDevice.current().systemVersion
        #elseif os(macOS) || targetEnvironment(macCatalyst)
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
        #endif
    }

    static var currentAppName: String {
        if let name = Bundle.main.localizedValue(for: "CFBundleDisplayName") {
            return name
        } else if let name = Bundle.main.localizedValue(for: "CFBundleName") {
            return name
        } else {
            return ProcessInfo.processInfo.processName
        }
    }
}

extension Bundle {
    func localizedValue(for key: String) -> String? {
        if let localizedInfoDictionary,
           let value = localizedInfoDictionary[key] as? String {
            return value
        } else if let infoDictionary,
                  let value = infoDictionary[key] as? String {
            return value
        } else {
            return nil
        }
    }
}
