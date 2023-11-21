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
    #if os(iOS) || os(macOS)
    @Environment(ThemeManager.self) private var themeManager
    private var extraColorCSS: String {
        #"""
        :root {
            --link-color: #\#(themeManager.lightColor.toHex(alpha: true) ?? "");
            --header-link-color: #\#(themeManager.lightColor.toHex(alpha: true) ?? "");
        }
        
        @media(prefers-color-scheme: dark) {
            :root {
                --link-color: #\#(themeManager.darkColor.toHex(alpha: true) ?? "");
                --header-link-color: #\#(themeManager.darkColor.toHex(alpha: true) ?? "");
            }
        }
        """#
    }
    #else
    private var extraColorCSS: String { "" }
    #endif
    private var padding: Double { 10 }

    private var extraGeneralCSS: String {
        #"""
        :root {
        --content-margin: \#(padding)px;
        }
        """#
    }
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            authorArea.padding(.horizontal, padding)
            bodyArea
            extensionArea.padding(.horizontal, padding)
        }
    }

    var authorArea: some View {
        HStack {
            EqualHeightHStackLayout {
                AsyncImage(url: state.avatarURL(for: post)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .clipShape(Circle())
                    
                VStack(alignment: .leading) {
                    Text(post.username) + Text(" ") + Text(post.name).foregroundStyle(.secondary)
                    post.createdAt.formattedText
                        .foregroundStyle(.secondary)
                }
                .lineLimit(1)
            }
        }
    }
    
    #if os(iOS) || os(visionOS) || os(macOS)
    private var tapMethod: HtmlText.HttpLinkTap {
        #if os(iOS) || os(visionOS)
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
        #if os(iOS) || os(visionOS) || os(macOS)
        // TODO: Add forum specific css injection
        HtmlText(
            body: post.cooked,
            css: .init(
                fontFaces: [],
                css: PostView.defaultCSS + extraColorCSS + extraGeneralCSS
            ),
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
        .foregroundStyle(.secondary)
        .disabled(!post.likeCanAct)
    }
}

extension PostView {
    static let defaultCSS: String = {
        guard let url = Bundle.main.url(forResource: "styleSheet", withExtension: "css")
        else { return "" }
        return (try? String(contentsOf: url)) ?? ""
    }()
}

#if DEBUG
@_implementationOnly import LoremSwiftum

#Preview("1") {
    let data = #"""
    {
        "id": 1,
        "name": "Test1",
        "username": "Test2",
        "avatar_template": "https://picsum.photos/200",
        "created_at": "2023-08-21T15:35:28.305Z",
        "cooked": "<aside class=\"quote no-group\" data-username=\"Demo\" data-post=\"4\" data-topic=\"67152\">\n<div class=\"title\">\n<div class=\"quote-controls\"></div>\n<img loading=\"lazy\" alt=\"\" width=\"24\" height=\"24\" src=\"https://sea2.discourse-cdn.com/swift/user_avatar/forums.swift.org/ensan-hcl/48/15186_2.png\" class=\"avatar\"> Demo:</div>\n<blockquote>\n<p>\#(Lorem.tweet) <code>CodeExample</code> <a href=\"https://example.com\">Example Link</a></p>\n</blockquote>\n</aside>\n<p>\#(Lorem.tweet).</p>",
        "actions_summary": []
    }
    """#.data(using: .utf8)!
    let post = try! JSONDecoder.discourse.decode(Post.self, from: data)
    return PostView(post: post)
        .environmentObject(CommunityDetailState(community: .swift))
    #if os(iOS) || os(macOS)
        .environment(ThemeManager())
    #endif
}

#Preview("2") {
    let data = #"""
    {
        "id": 1,
        "name": "Test1",
        "username": "Test2",
        "avatar_template": "https://picsum.photos/200",
        "created_at": "2023-08-21T15:35:28.305Z",
        "cooked": "<aside class=\"quote no-group\" data-username=\"User\" data-post=\"6\" data-topic=\"67152\">\n<div class=\"title\">\n<div class=\"quote-controls\"></div>\n<img loading=\"lazy\" alt=\"\" width=\"24\" height=\"24\" src=\"https://sea2.discourse-cdn.com/swift/user_avatar/forums.swift.org/wadetregaskis/48/8494_2.png\" class=\"avatar\"> User:</div>\n<blockquote>\n<p>\#(Lorem.tweet)</p>\n</blockquote>\n</aside>\n<p>\#(Lorem.paragraph)</p>\n<pre><code class=\"lang-swift\">protocol S {\n  func decode(_ encoded: some Collection&lt;UInt8&gt;) -&gt; any Collection&lt;UInt8&gt;\n}\n</code></pre>\n<p>\#(Lorem.paragraph)</p>",
        "actions_summary": []
    }
    """#.data(using: .utf8)!
    let post = try! JSONDecoder.discourse.decode(Post.self, from: data)
    return ScrollView {
        PostView(post: post)
    }
    .environmentObject(CommunityDetailState(community: .swift))
    #if os(iOS) || os(macOS)
        .environment(ThemeManager())
    #endif
}
#endif
