//
//  LatestTopicsView.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct LatestTopicsView: View {
    var showButton = true

    var body: some View {
        Section {} header: {
            CommunitySectionHeader(text: "Latest Topics", showButton: showButton)
        }
    }
}

struct LatestTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestTopicsView()
    }
}
