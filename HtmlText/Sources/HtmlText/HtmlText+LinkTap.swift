//
//  HtmlText+LinkTap.swift
//
//
//  Created by Yanis Plumit on 05.02.2023.
//

#if canImport(SafariServices)
import SafariServices

extension HtmlText {
    public enum HttpLinkTap {
        case openSafariApp
        #if os(iOS) || os(visionOS)
        case openSFSafariModal
        #endif
    }
    
    public static func defaultLinkTapHandler(httpLinkTap: HttpLinkTap) -> ((URL) -> Void) {
        { url in
            switch httpLinkTap {
            case .openSafariApp:
                #if os(macOS)
                NSWorkspace.shared.open(url)
                #elseif os(iOS) || os(visionOS) || os(tvOS)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                #endif
            #if os(iOS) || os(visionOS)
            case .openSFSafariModal:
                let safari = SFSafariViewController(url: url)
                let vc = UIApplication.topModalViewController
                vc?.present(safari, animated: true, completion: nil)
            #endif
            }
        }
    }
}
#endif
