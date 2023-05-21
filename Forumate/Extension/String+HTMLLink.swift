//
//  String+HTMLLink.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Foundation
import RegexBuilder

extension String {
    func replacingHTMLLink() -> String {
        let regex = /<a href="(?<link>[^"]+)">(?<label>[^<]+)<\/a>/
        return replacing(regex) { match in
            "[\(match.label)](\(match.link))"
        }
    }
}
