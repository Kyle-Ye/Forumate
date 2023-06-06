//
//  AppInfo.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation
#if os(iOS) || os(tvOS)
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
        #if (os(iOS) && !targetEnvironment(macCatalyst)) || os(tvOS)
        UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        #elseif os(watchOS)
        WKInterfaceDevice.current().systemName + " " + WKInterfaceDevice.current().systemVersion
        #elseif os(macOS) || targetEnvironment(macCatalyst)
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
        #endif
    }
}
