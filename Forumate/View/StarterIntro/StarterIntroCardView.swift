//
//  StarterIntroCardView.swift
//  Forumate
//
//  Created by Kyle on 2023/6/7.
//

import SwiftUI

struct StarterIntroCardView<S: ShapeStyle>: View {
    let card: StarterIntroCard<S>
    
    var body: some View {
        HStack {
            Image(systemName: card.image)
                .symbolRenderingMode(.hierarchical)
                .font(.largeTitle)
                
                .padding(.horizontal)
            Text(card.text)
            Spacer()

        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(card.style, in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}

struct StarterIntroCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StarterIntroCardView(card: StarterIntroCard(image: "macwindow.badge.plus", text: "Multiple Window support", style: .blue.opacity(0.3)))
            StarterIntroCardView(card: StarterIntroCard(image: "macwindow.badge.plus", text: "Multiple Window support", style: .yellow.opacity(0.3)))
        }
    }
}
