//
//  AppInfo.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation
import UIKit
#if os(watchOS)
import WatchKit
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

    static var OSVersion: String {
        #if os(watchOS)
        WKInterfaceDevice.current().systemName + " " + WKInterfaceDevice.current().systemVersion
        #else
        UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        #endif
        
    }
}
