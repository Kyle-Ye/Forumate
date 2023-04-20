//
//  ContentView.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

class ForumateController: ObservableObject {
    
}
// @Published var selectedCommunityID
// @Published var selectedCommunity
// @Published var selectedCategory

struct ContentView: View {
//    @EnvironmentObject var forumateController
    
    @State private var a = false
    
    var body: some View {
        NavigationSplitView {
            CommunityList()
        } content: {
            Text("2")
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
    }
}
