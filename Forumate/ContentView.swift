//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import DiscourseKit
import SwiftUI

class ForumateController: ObservableObject {
    @Published var selectedCommunity: Community?
    
//    var client: DKClient
}

// @Published var selectedCommunityID
// @Published var selectedCategory

struct ContentView: View {
    @EnvironmentObject var forumateController: ForumateController
    
    @State private var a = false
    
    var body: some View {
        NavigationSplitView {
            CommunityList()
        } content: {
            Text("No Community is selected")
        } detail: {
            Text("3")
                .onTapGesture {
                    a.toggle()
                }
                .sheet(isPresented: $a) {
                    Text("3")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ForumateController())
    }
}
