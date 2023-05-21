//
//  StarterIntro.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct StarterIntro: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Welcome to Forumate")
                    .font(.system(.title, design: .serif, weight: .bold))
                    #if !os(watchOS)
                    .padding(.top, 200)
                    #endif
            }
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

struct StarterIntro_Previews: PreviewProvider, View {
    @State private var present = true
    
    var body: some View {
        Button("Show Starter Intro") {
            present.toggle()
        }
        .sheet(isPresented: $present) {
            StarterIntro()
        }
    }
    
    static var previews: some View {
        StarterIntro_Previews()
    }
}
