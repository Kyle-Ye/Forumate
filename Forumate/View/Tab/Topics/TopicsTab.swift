//
//  TopicsTab.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import SwiftUI

struct TopicsTab: View {
    @StateObject var tabState = TopicsTabState()
    
    var body: some View {
        NavigationSplitView {
            TopicsTabRoot()
                .environmentObject(tabState)
        } content: {
            PlaceholderView(text: "No Community Selected",
                            image: "rectangle.3.group.bubble.left")
        } detail: {
            PlaceholderView(text: "No Topic Selected")
        }
    }
}

struct TopicsTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopicsTab()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone")
            TopicsTab()
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad")
        }
        .environmentObject(AppState())
    }
}
