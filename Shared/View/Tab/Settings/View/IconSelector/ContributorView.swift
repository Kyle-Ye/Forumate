//
//  ContributorView.swift
//  Forumate
//
//  Created by Kyle on 2023/9/6.
//

import SwiftUI

struct ContributorView: View {
    var info: ContributorInfo
    
    #if os(tvOS)
    @ScaledMetric
    private var size = 100
    #else
    @ScaledMetric
    private var size = 20
    #endif
    
    var body: some View {
        HStack {
            AsyncImage(url: info.avatar) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            #if os(tvOS)
            Text(info.name)
            #else
            Link(destination: info.site) {
                Text(info.name)
            }
            #endif
        }
        .font(.footnote)
    }
}

struct ContributorInfo: Codable {
    let name: String
    let mail: String
    let avatar: URL?
    let site: URL
    
    static let kyle = ContributorInfo(
        name: "Kyle-Ye",
        mail: "kyle201817146@gmail.com",
        avatar: URL(string: "https://www.gravatar.com/avatar/12e31d08f83a0cec342ce249e4450a90"),
        site: URL(string: "https://kyleye.top")!
    )
    
    static let frad = ContributorInfo(
        name: "Frad LEE",
        mail: "fradser@gmail.com",
        avatar: URL(string: "https://www.gravatar.com/avatar/13c991717b76d4585166f688886ae6a3"),
        site: URL(string: "https://frad.me")!
    )
}

#Preview {
    VStack {
        ContributorView(info: .kyle)
        ContributorView(info: .frad)
    }
}
