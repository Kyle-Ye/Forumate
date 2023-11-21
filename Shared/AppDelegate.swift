//
//  AppDelegate.swift
//  Forumate
//
//  Created by Kyle on 2023/9/10.
//

import SDWebImageSwiftUI
import SDWebImageSVGCoder
import SDWebImage

#if os(iOS) || os(visionOS) || os(tvOS)
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder())
        return true
    }
}
#elseif os(watchOS)
class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder())
    }
}
#elseif os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder())
    }
}
#endif
