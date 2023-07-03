//
//  AppIcon.swift
//  Forumate
//
//  Created by Kyle on 2023/6/20.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    AppIcon()
        .clipShape(Circle())
}
