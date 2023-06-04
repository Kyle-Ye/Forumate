//
//  CSS+Constructor.swift
//
//
//  Created by Kyle on 2023/6/4.
//

import Foundation
import SwiftUI

public class CSSConstructor {
    var fontFaces: [FontFace] = []
    var fontFamily = ""
    var fontSize = ""
    var lineHeight = ""
    var letterSpacing = ""
    var textIndent = ""
    var textColor = ""
    var paragraphPadding = ""
    var linkColor = ""
    var linkDecoration = ""
    var listPadding = ""
    
    public init() {}
    
    public func text(fontName: String, fileName: String?, size: CGFloat, lineHeight: CGFloat, letterSpacing: CGFloat, textIndent: CGFloat, color: Color) -> CSSConstructor {
        self.fontFamily = "font-family: \(fontName);"
        self.fontSize = "font-size: \(size)px;"
        self.lineHeight = "line-height: \(lineHeight)px;"
        self.textColor = "color:#\(color.toHex(alpha: true) ?? "");"
        self.letterSpacing = "letter-spacing: \(letterSpacing)px;"
        self.textIndent = "text-indent: \(textIndent)px;"
        self.fontFaces = {
            guard let fileName else { return [] }
            return [.init(fontName: fontName, fileName: fileName)]
        }()
        return self
    }
    
    public func link(color: Color, underlined: Bool) -> CSSConstructor {
        self.linkColor = "color:#\(color.toHex(alpha: true) ?? "");"
        self.linkDecoration = underlined ? "" : "a {text-decoration: none;}"
        return self
    }
    
    public func link(color: UIColor, underlined: Bool) -> CSSConstructor {
        self.linkColor = "color:#\(color.toHex(alpha: true) ?? "");"
        self.linkDecoration = underlined ? "" : "a {text-decoration: none;}"
        return self
    }
    
    public func list(padding: UIEdgeInsets) -> CSSConstructor {
        listPadding =
            """
            padding-left: \(padding.left)px;
            padding-top: \(padding.top)px;
            padding-right: \(padding.right)px;
            padding-bottom: \(padding.bottom)px;
            """
        return self
    }

    public func paragraph(padding: UIEdgeInsets) -> CSSConstructor {
        paragraphPadding =
            """
            padding-left: \(padding.left)px;
            padding-top: \(padding.top)px;
            padding-right: \(padding.right)px;
            padding-bottom: \(padding.bottom)px;
            """
        return self
    }
    
    public var css: CSS {
        CSS(fontFaces: fontFaces, css:
            """
            * {
                padding: 0px;
                margin: 0px;
                \(fontFamily)
                \(fontSize)
                \(lineHeight)
                \(textColor)
                \(letterSpacing)
                \(textIndent)
            }
            p {
                \(paragraphPadding)
            }
            ul, ol {
                \(listPadding)
                text-indent: 0px;
            }
            li {
                text-indent: 0px;
            }
            \(linkDecoration)
            a:link {\(linkColor);}
            a:visited {\(linkColor);}
            a:active {color:#000000;}
            """)
    }
}

#if os(macOS)
public typealias UIColor = NSColor
public typealias UIEdgeInsets = NSEdgeInsets

extension NSEdgeInsets {
    public static var zero: NSEdgeInsets { NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
}
#endif
