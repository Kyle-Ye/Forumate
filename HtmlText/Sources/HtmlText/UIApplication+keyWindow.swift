//
//  File.swift
//
//
//  Created by Yanis Plumit on 05.02.2023.
//

#if !os(watchOS)
import UIKit

extension UIApplication {
    public var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState != .unattached }
            .first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)
    }
    
    public static var topModalViewController: UIViewController? {
        UIViewController.topModalViewController()
    }
}

extension UIViewController {
    public var topModalViewController: UIViewController? {
        type(of: self).topModalViewController(vc: self)
    }
    
    public static func topModalViewController(vc: UIViewController?) -> UIViewController? {
        var result = vc
        while result?.presentedViewController != nil {
            result = result?.presentedViewController
        }
        return result
    }

    public static func topModalViewController() -> UIViewController? {
        topModalViewController(vc: UIApplication.shared.keyWindow?.rootViewController)
    }
}
#endif
