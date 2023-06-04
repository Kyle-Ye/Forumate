//
//  FontFace.swift
//
//
//  Created by Kyle on 2023/6/4.
//

import Foundation

public struct FontFace {
    public let fontName: String
    public let fileName: String
    
    public var htmlString: String {
        if fileName.lowercased().hasSuffix(".ttf") {
            return "@font-face { font-family: '\(fontName)'; src: url('\(fileName)') format('truetype'); }"
        } else if fileName.lowercased().hasSuffix(".otf") {
            return "@font-face { font-family: '\(fontName)'; src: url('\(fileName)') format('opentype'); }"
        } else {
            assertionFailure("unknown font type")
            let fileExtension = String(fileName.split(separator: ".").last ?? "")
            return "@font-face { font-family: '\(fontName)'; src: url('\(fileName)') format('\(fileExtension)'); }"
        }
    }
}
