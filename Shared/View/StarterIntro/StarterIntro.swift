//
//  StarterIntro.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct StarterIntro: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    #if os(iOS) || os(visionOS)
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    #endif
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Welcome to Forumate")
                        .font(.system(.title, design: .serif, weight: .bold))
                        .padding()
                        .background(.tint.opacity(0.3), in: RoundedRectangle(cornerRadius: 20))
                    #if os(iOS) || os(visionOS)
                        .padding(.top, verticalSizeClass == .regular ? 100 : 0)
                    #endif
                    Text("Highlighted Features")
                        .font(.system(.title, design: .serif, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    StarterIntroCardView(card: StarterIntroCard(image: "lasso.and.sparkles", text: "Native Client with Multiple OS Support", style: .pink.opacity(0.3)))
                    if supportsMultipleWindows {
                        StarterIntroCardView(card: StarterIntroCard(image: "macwindow.badge.plus", text: "Multiple Window Support", style: .blue.opacity(0.3)))
                    }
                }
            }
            .frame(maxWidth: .infinity)

            Button {
                dismiss()
            } label: {
                Text("Continue")
                    .font(.system(.body, design: .rounded, weight: .bold))
                #if !os(watchOS)
                    .padding(.vertical, 5)
                #endif
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            #if !os(watchOS)
                .padding(.horizontal, 50)
                .padding(.vertical)
            #endif
        }
    }
}

#Preview("Sheet") {
    @State var present = true
    return Button("Show Starter Intro") {
        present.toggle()
    }
    .sheet(isPresented: $present) {
        StarterIntro()
    }
}

#Preview("Intro") {
    StarterIntro()
}
