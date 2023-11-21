//
//  Toast.swift
//  Forumate
//
//  Created by Kyle on 2023/9/1.
//

import SimpleToast
import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, label: @escaping () -> some View) -> some View {
        simpleToast(
            isPresented: isPresented,
            options: SimpleToastOptions(
                alignment: .top,
                hideAfter: 2,
                backdrop: nil,
                animation: .spring,
                modifierType: .slide,
                dismissOnTap: true
            )
        ) {
            label().labelStyle(ToastLabelStyle())
        }
    }
}

struct ToastLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
        .padding()
        .background(.tint)
        .background(.thinMaterial)
        .clipShape(Capsule())
    }
}

struct Demo: View {
    @State var isPresented = false
    
    @ViewBuilder
    func random() -> some View {
        switch Int.random(in: 0 ..< 3) {
        case 0: Color.red
        case 1: Color.yellow
        case 2: Color.blue
        default: EmptyView()
        }
    }
    
    var body: some View {
        List {
            ForEach(0 ..< 10) { _ in
                random()
            }
            Button {
                isPresented.toggle()
            } label: {
                Text(verbatim: "Hello, World!")
            }
        }
        .toast(isPresented: $isPresented) {
            Label(
                title: { Text(verbatim: "Copied into clipboard") },
                icon: { Image(systemName: "doc.on.clipboard") }
            )
            .foregroundStyle(.white)
            .tint(.accent.opacity(0.8))
        }
    }
}

#Preview {
    Demo()
}
