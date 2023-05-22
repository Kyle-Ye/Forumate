//
//  ForumateApp.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

@main
struct ForumateApp: App {
    #if os(iOS)
    @UIApplicationDelegateAdaptor private var delegate: AppDelegate
    #endif
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
//        WindowGroup(id: "add-community") {
//            NewCommunityView()
//        }
    }
}

#if os(iOS)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if options.userActivities.first?.activityType == "top.kyleye.Forumate.add-community" {
            let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
            configuration.delegateClass = SceneDelegate.self
            return configuration
        } else {
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: NewCommunity())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
//    let options = UIWindowScene.ActivationRequestOptions()
//    options.preferredPresentationStyle = .prominent
//    let userActivity = NSUserActivity(activityType: "top.kyleye.Forumate.add-community")
//    userActivity.targetContentIdentifier = "top.kyleye.Forumate.add-community"
//    UIApplication.shared.requestSceneSessionActivation(nil,
//        userActivity: userActivity,
//        options: options,
//        errorHandler: nil)
}
#endif
