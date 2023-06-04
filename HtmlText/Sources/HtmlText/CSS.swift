//
//  CSS.swift
//  
//
//  Created by Kyle on 2023/6/4.
//

import Foundation

public struct CSS {
    public let fontFaces: [FontFace]
    public let css: String
    
    public init(fontFaces: [FontFace], css: String) {
        self.fontFaces = fontFaces
        self.css = css
    }
    
    public func makeHtml(body: String) -> String {
        let fontFaces: [String] = fontFaces.map { $0.htmlString }
        return """
        <!doctype html>
         <html>
            <head>
              <meta name='viewport' content='width=device-width, shrink-to-fit=YES, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
              <style>
                \(css)
                \(fontFaces.joined(separator: "\n"))
              </style>
            </head>
            <body>
              \(body)
            </body>
          </html>
        """
    }
}
