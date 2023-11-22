//
//  RecommendCommunity.swift
//  Forumate
//
//  Created by Kyle on 2023/9/10.
//

import Foundation

struct RecommendCommunity {
    enum Kind {
        /// Other kind
        case other
        /// Programming language kind
        case lang
        /// Game kind
        case game
        /// Design kind
        case design
        /// Web kind
        case web
        /// AI kind
        case ai
    }
    
    let title: String
    let host: URL
    let kind: Kind
    
    init(title: String, host: URL, kind: Kind = .other) {
        self.title = title
        self.host = host
        self.kind = kind
    }
    
    init(_ title: String, _ urlString: StaticString, _ kind: Kind = .other) {
        self.title = title
        self.host = URL(string: "\(urlString)")!
        self.kind = kind
    }
}

extension RecommendCommunity: Identifiable {
    var id: String { title }
}

extension [RecommendCommunity] {
    static let all: [RecommendCommunity] = [
        .init("Swift Forums", "https://forums.swift.org", .lang),
        .init("The Rust Programming Language Forum", "https://users.rust-lang.org", .lang),
        .init("Rust Internals", "https://internals.rust-lang.org", .lang),
        .init("Discourse Meta", "https://meta.discourse.org", .other),
        .init("OpenAI Developer Forum", "https://community.openai.com", .ai),
        .init("Figma Community Forum", "https://forum.figma.com", .design),
        .init("Netlify Support Forums", "https://answers.netlify.com", .web),
    ]
    
    static let recommended: [RecommendCommunity] = [RecommendCommunity.Kind: [RecommendCommunity]](
        grouping: all,
        by: \.kind
    )
    .compactMapValues { $0.randomElement() }
    .reduce(into: [RecommendCommunity]()) { partialResult, element in
        partialResult.append(element.value)
    }
}
