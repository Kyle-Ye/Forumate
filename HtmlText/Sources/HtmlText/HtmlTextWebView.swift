//
//  HtmlTextWebView.swift
//
//
//  Created by Kyle on 2023/6/4.
//

#if os(iOS) || os(macOS) || os(watchOS)
import os.log
import SwiftUI
import WebKit

#if os(iOS)
struct HtmlTextWebView: UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    let html: String
    let linkTap: ((URL) -> Void)?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = true
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        }
        return webView
    }
    
    func updateUIView(_: WKWebView, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator _: Coordinator) {
        uiView.navigationDelegate = nil
    }
}
#elseif os(watchOS)
struct HtmlTextWebView: UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    let html: String
    let linkTap: ((URL) -> Void)?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = true
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        }
        return webView
    }
    
    func updateUIView(_: WKWebView, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator _: Coordinator) {
        uiView.navigationDelegate = nil
    }
}

#elseif os(macOS)
struct HtmlTextWebView: NSViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    let html: String
    let linkTap: ((URL) -> Void)?
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        DispatchQueue.main.async {
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        }
        return webView
    }
    
    func updateNSView(_: WKWebView, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    static func dismantleNSView(_ uiView: WKWebView, coordinator _: Coordinator) {
        uiView.navigationDelegate = nil
    }
}

#endif


extension HtmlTextWebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        let criticalHeight: CGFloat = 99999
        var parent: HtmlTextWebView
        
        let logger = Logger(subsystem: "HtmlTextWebView", category: "Coordinator")
        
        init(_ parent: HtmlTextWebView) {
            self.parent = parent
        }
        
        public func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            Task { @MainActor in
                logger.debug("Coordinator: \(self)")
                logger.debug("Begin evaluate height")
                let value = try await webView.evaluateJavaScript("document.documentElement.scrollHeight")
                logger.debug("End evaluate height")
                guard let scrollHeight = value as? Double else {
                    return
                }
                logger.debug("Height: \(scrollHeight)")
                if scrollHeight < self.criticalHeight {
                    self.parent.dynamicHeight = scrollHeight
                }
            }
        }
        
        func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard navigationAction.navigationType == WKNavigationType.linkActivated,
                  let url = navigationAction.request.url else {
                decisionHandler(WKNavigationActionPolicy.allow)
                return
            }
            parent.linkTap?(url)
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        
        override var description: String {
            super.description + " Hash" + parent.html.hashValue.description
        }
    }
}
#endif
