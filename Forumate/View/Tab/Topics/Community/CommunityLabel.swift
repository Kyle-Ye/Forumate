//
//  CommunityLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct CommunityLabel: View {
    let community: Community
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        HStack {
            AsyncImage(url: community.icon) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "rectangle.3.group.bubble.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: size.height, height: size.height)
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
            .readSize { size in
                DispatchQueue.main.async {
                    self.size = size
                }
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
