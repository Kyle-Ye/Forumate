//
//  HtmlText.swift
//
//
//  Created by Yanis Plumit on 05.02.2023.
//

import SwiftUI

public struct HtmlText: View {
    let html: String
    
    #if os(iOS) || os(macOS)
    @State private var dynamicHeight: CGFloat = .zero
    let linkTap: ((URL) -> Void)?
    
    public init(rawHtml: String, linkTap: ((URL) -> Void)?) {
        self.html = rawHtml
        self.linkTap = linkTap
    }
    
    public init(body: String, css: CSS, linkTap: ((URL) -> Void)?) {
        self.init(rawHtml: css.makeHtml(body: body), linkTap: linkTap)
    }
    
    public var body: some View {
        HtmlTextWebView(dynamicHeight: $dynamicHeight, html: html, linkTap: linkTap)
            .frame(height: dynamicHeight)
    }
    #else
    public init(rawHtml: String) {
        self.html = rawHtml
    }
    
    public var body: some View {
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.swiftUI) {
            Text(attributedString)
        } else {
            // fallback...
            Text(html)
        }
    }
    #endif
}
