//
//  CommunityList.swift
//  Forumate
//
//  Created by Kyle on 2023/4/19.
//

import SwiftUI

struct CommunityList: View {
    @Environment(\.openWindow) var openWindow

    var body: some View {
        List {
            Section {
                Text("1")
            } header: {
                Text("My Communities")
            }
        }
        .navigationTitle("Communities")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
//                    openWindow(id: "add-community")
                    
                    let options = UIWindowScene.ActivationRequestOptions()
                    options.preferredPresentationStyle = .prominent
                    let userActivity = NSUserActivity(activityType: "top.kyleye.Forumate.add-community")
                    userActivity.targetContentIdentifier = "top.kyleye.Forumate.add-community"
                    UIApplication.shared.requestSceneSessionActivation(nil,
                        userActivity: userActivity,
                        options: options,
                        errorHandler: nil)
                } label: {
                    Label("Add Community", systemImage: "plus.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
        

    }
}

struct CommunityList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityList()
        }
    }
}
