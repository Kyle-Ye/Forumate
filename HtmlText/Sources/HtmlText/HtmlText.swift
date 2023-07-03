//
//  HtmlText.swift
//
//
//  Created by Yanis Plumit on 05.02.2023.
//

import SwiftUI

#if os(iOS) || os(macOS)
public struct HtmlText: View {
    let html: String
    
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
}
#else
public typealias HtmlText = AttributedText
#endif
