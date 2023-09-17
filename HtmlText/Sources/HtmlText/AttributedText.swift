//
//  AttributedText.swift
//
//
//  Created by Kyle on 2023/7/3.
//

import SwiftUI

public struct AttributedText: View {
    let html: String
    
    public init(rawHtml: String) {
        self.html = rawHtml
    }
    
    @State private var nsAttributedString: NSAttributedString?
    
    public var body: some View {
        if let nsAttributedString,
           let attributedString = try? AttributedString(nsAttributedString, including: \.swiftUI) {
            Text(attributedString)
        } else {
            Text(html)
                .task {
                    nsAttributedString = try? NSAttributedString(data: Data(fixedString.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                }
        }
    }
    
    // FIXME: "’" will get a strange effect, we replace it with "'" as a workaround
    private var fixedString: String {
        html.replacing(#/’/#) { _ in "'" }
    }
}

#Preview {
    VStack {
        AttributedText(rawHtml: "Topics <br>related</br> to the <a href=\"https://github.com/apple/swift-evolution/blob/main/process.md\">Swift Evolution Process</a>.")
        AttributedText(rawHtml: "Questions, feedback, and best practices around building with OpenAI’s API. Please read the <a href=\"https://platform.openai.com/overview\">API docs</a> before posting.")
    }
}
