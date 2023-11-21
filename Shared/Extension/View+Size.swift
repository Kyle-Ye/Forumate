//
//  View+Size.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import SwiftUI

extension View {
    @available(*, deprecated, message: "Please use a custom Layout instead of this API")
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                let _ = onChange(geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { value in
            onChange(value)
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}
