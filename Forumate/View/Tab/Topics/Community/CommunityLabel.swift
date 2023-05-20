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
            // TODO: Add community icon support
            AsyncImage(url: nil) { image in
                image
            } placeholder: {
                Image(systemName: "rectangle.3.group.bubble.left")
            }
            Text(community.name)
        }
    }
}

struct CommunityLabel_Previews: PreviewProvider {
    static var previews: some View {
        CommunityLabel(community: .swift)
    }
}
