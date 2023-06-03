//
//  PostView.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import DiscourseKit
#if os(watchOS)
struct HTMLText: View {
    let html: String
    
    var body: some View {
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            Text(attributedString)
        } else {
            // fallback...
            Text(html)
        }
    }
}
#else
import HtmlText
#endif
import SwiftUI

struct PostView: View {
    @EnvironmentObject private var state: CommunityDetailState

    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            authorArea
            bodyArea
            extensionArea
        }
    }
    
    @State private var size: CGSize = .zero
    
    var authorArea: some View {
        HStack {
            AsyncImage(url: state.avatarURL(for: post)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: size.height, height: size.height)
            .clipShape(Circle())
                
            VStack(alignment: .leading) {
                Text(post.username) + Text(" ") + Text(post.name).foregroundColor(.secondary)
                Text("\(post.createdAt, style: .relative) ago").foregroundColor(.secondary)
            }
            .lineLimit(1)
            .readSize { size in
                DispatchQueue.main.async {
                    self.size = size
                }
            }
        }
    }
    
    var bodyArea: some View {
        #if os(watchOS)
        HTMLText(html: post.cooked)
        #else
        // TODO: Dynamic font change
        HtmlText(
            body: post.cooked,
            css: .init(fontFaces: [], css: #"""
            :root {
                font: -apple-system-body;
                color-scheme: light dark; /* enable light and dark mode compatibility */
                supported-color-schemes: light dark; /* enable light and dark mode */
            }
            """#),
            linkTap: HtmlText.defaultLinkTapHandler(httpLinkTap: .openSFSafariModal)
        )
        #endif
    }
    
    var extensionArea: some View {
        HStack {
            Button {} label: {
                Image(systemName: "heart")
            }
            if post.likeCount != 0 {
                Text(post.likeCount.description)
            }
        }
        .foregroundColor(.secondary)
        .disabled(!post.likeCanAct)
    }
}

// struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: )
//    }
// }
