//
//  CommunityLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CommunityLabel: View {
    let community: Community
    
    var body: some View {
        HStack {
            AsyncImage(url: community.icon) { image in
                image
                    .resizable()
                    #if os(watchOS)
                    .frame(width: 30, height: 30)
                    #else
                    .frame(width: 40, height: 40)
                    #endif
            } placeholder: {
                Image(systemName: "rectangle.3.group.bubble.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            }
            VStack(alignment: .leading) {
                Text(community.title)
                    .font(.system(.body, design: .rounded))
//                HStack {
//                    Text("14 New 167 Unread")
//                }
//                .font(.footnote)
//                .foregroundColor(.secondary)
            }
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
