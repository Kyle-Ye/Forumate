//
//  CommunityLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommunityLabel: View {
    let community: Community
    
    var body: some View {
        EqualHeightHStackLayout {
            // Use WebImage for svg image support
            WebImage(url: community.icon)
                .placeholder(Image(systemName: "rectangle.3.group.bubble.left"))
                .resizable()
                .aspectRatio(/*1, */contentMode: .fit) // SDWebImageSwiftUI Bug
            VStack(alignment: .leading) {
                Text(community.title)
                    .font(.system(.body, design: .rounded))
                //                HStack {
                //                    Text("14 New 167 Unread")
                //                }
                //                .font(.footnote)
                //                .foregroundColor(.secondary)
            }
            .lineLimit(1)
        }
    }
}

struct CommunityLabel_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CommunityLabel(community: .swift)
            CommunityLabel(community: .swift)
        }
    }
}
