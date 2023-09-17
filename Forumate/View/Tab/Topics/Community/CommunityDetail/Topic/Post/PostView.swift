//
//  PostView.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import DiscourseKit
import HtmlText
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
    
    #if os(iOS) || os(macOS)
    private var tapMethod: HtmlText.HttpLinkTap {
        #if os(iOS)
        let type = OpenLinkTypeSetting.value
        switch type {
        case .modal: return .openSFSafariModal
        case .safari: return .openSafariApp
        }
        #elseif os(macOS)
        .openSafariApp
        #endif
    }
    #endif

    var bodyArea: some View {
        #if os(iOS) || os(macOS)
        // TODO: Dynamic font change
        // FIXME: Link AccentColor will not change for dark/light toggle
        HtmlText(
            body: post.cooked,
            css: .init(fontFaces: [], css: #"""
            :root {
                font: -apple-system-body;
                color-scheme: light dark; /* enable light and dark mode compatibility */
                supported-color-schemes: light dark; /* enable light and dark mode */
            }
            """# + CSSConstructor().list(padding: .zero).paragraph(padding: .zero).link(color: UIColor(named: "AccentColor")!, underlined: false).css.css),
            linkTap: HtmlText.defaultLinkTapHandler(httpLinkTap: tapMethod)
        )
        #else
        HtmlText(rawHtml: post.cooked)
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
