//
//  SettingIcon.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI

struct SettingIcon<S: ShapeStyle>: View {
    let icon: String
    let style: S
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(width: 15, height: 15)
            .padding(5)
            .background(style, in: RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    SettingIcon(icon: "gear", style: .gray)
}
