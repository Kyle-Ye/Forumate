//
//  PostActionCodeView.swift
//  Forumate
//
//  Created by Kyle on 2023/9/11.
//

import DiscourseKit
import HtmlText
import SwiftUI

struct PostActionCodeView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName).imageScale(.large)
                AsyncImage(url: state.avatarURL(for: post)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .clipShape(Circle())
                .frame(width: smallAvatarSize, height: smallAvatarSize)
                .padding(.horizontal, padding)
                text.textCase(.uppercase)
                    .bold()
                Spacer()
            }
            .foregroundStyle(.gray)
            // FIXME: The link may be relative to the community host. (eg. "/t/30038")
            AttributedText(rawHtml: post.cooked)
        }
    }
    
    @EnvironmentObject private var state: CommunityDetailState

    @ScaledMetric
    private var smallAvatarSize = 20

    private var padding: Double { 2 }
    
    private var iconName: String {
        if post.isPinned {
            "pin.fill"
        } else if post.isClosed {
            "lock.fill"
        } else if post.isSplit {
            "arrow.triangle.branch"
        } else {
            ""
        }
    }
    
    private var text: Text {
        if post.isPinned {
            Text("Pinned \(post.createdAt.formattedText)")
        } else if post.isClosed {
            Text("Closed \(post.createdAt.formattedText)")
        } else if post.isSplit {
            Text("Split this topic \(post.createdAt.formattedText)")
        } else {
            Text("\(post.createdAt.formattedText)")
        }
    }
}

#Preview {
    let pinnedData = #"""
    {
        "id": 1,
        "name": "Test1",
        "username": "Test2",
        "action_code": "pinned.enabled",
        "avatar_template": "https://picsum.photos/200",
        "created_at": "2023-08-21T15:35:28.305Z",
        "cooked": "",
        "actions_summary": []
    }
    """#.data(using: .utf8)!
    let closedData = #"""
    {
        "id": 1,
        "name": "Test1",
        "username": "Test2",
        "action_code": "closed.enabled",
        "avatar_template": "https://picsum.photos/200",
        "created_at": "2023-08-21T15:35:28.305Z",
        "cooked": "",
        "actions_summary": []
    }
    """#.data(using: .utf8)!
    let splitData = #"""
    {
        "id": 1,
        "name": "Test1",
        "username": "Test2",
        "action_code": "split_topic",
        "avatar_template": "https://picsum.photos/200",
        "created_at": "2023-08-21T15:35:28.305Z",
        "cooked": "<p>A post was split to a new topic: <a href=\"/t/problem-with-if-and-else/30038\">Problem with if and else</a></p>",
        "actions_summary": []
    }
    """#.data(using: .utf8)!
    let pinnedPost = try! JSONDecoder.discourse.decode(Post.self, from: pinnedData)
    let closedPost = try! JSONDecoder.discourse.decode(Post.self, from: closedData)
    let splitPost = try! JSONDecoder.discourse.decode(Post.self, from: splitData)

    return ScrollView {
        PostActionCodeView(post: pinnedPost)
        Divider()
        PostActionCodeView(post: closedPost)
        Divider()
        PostActionCodeView(post: splitPost)
    }
    .environmentObject(CommunityDetailState(community: .swift))
    #if os(iOS) || os(macOS)
        .environment(ThemeManager())
    #endif
}
