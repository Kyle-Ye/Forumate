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
        case openSFSafariModal
    }
    
    public static func defaultLinkTapHandler(httpLinkTap: HttpLinkTap) -> ((URL) -> Void) {
        { url in
            switch httpLinkTap {
            case .openSafariApp:
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            case .openSFSafariModal:
                let safari = SFSafariViewController(url: url)
                let vc = UIApplication.topModalViewController
                vc?.present(safari, animated: true, completion: nil)
            }
        }
    }
}
#endif
