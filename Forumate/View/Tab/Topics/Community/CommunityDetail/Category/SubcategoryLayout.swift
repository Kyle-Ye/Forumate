//
//  SubcategoryLayout.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import SwiftUI

struct SubcategoryLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        var totalWidth = 0.0
        var totalHeight = 0.0
        var maxWidth = 0.0
        var maxHeight = 0.0
        for subview in subviews {
            let size = subview.dimensions(in: .unspecified)
            if let proposalWidth = proposal.width, totalWidth + size.width > proposalWidth {
                // 下一行
                totalWidth = 0
                totalHeight += maxHeight
                maxHeight = 0
            }
            totalWidth += size.width
            maxWidth = max(maxWidth, totalWidth)
            maxHeight = max(maxHeight, size.height)
        }
        
        maxWidth = max(maxWidth, totalWidth)
        totalHeight += maxHeight
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    func placeSubviews(in rect: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        var totalWidth = 0.0
        var totalHeight = 0.0
        var maxWidth = 0.0
        var maxHeight = 0.0
        for subview in subviews {
            let size = subview.dimensions(in: .unspecified)
            if let proposalWidth = proposal.width, totalWidth + size.width > proposalWidth {
                // 下一行
                totalWidth = 0
                totalHeight += maxHeight
                maxHeight = 0
            }
            subview.place(at: CGPoint(x: rect.origin.x + totalWidth, y: rect.origin.y + totalHeight), anchor: .topLeading, proposal: proposal)
            totalWidth += size.width
            maxWidth = max(maxWidth, totalWidth)
            maxHeight = max(maxHeight, size.height)
        }
    }
}

struct SubcategoryLayout_Previews: PreviewProvider, View {
    @State private var width = 300.0
    
    var body: some View {
        VStack {
            SubcategoryLayout {
                Color.red.frame(width: 10, height: 10)
                Text("Hello")
                Color.blue.frame(width: 10, height: 10)
                Text("Hello123")
                Color.green.frame(width: 10, height: 10)
                Text("Hello123456")
            }
            .frame(width: width)
            .border(.yellow)
            .padding(.top, 200)
            Spacer()
            Slider(value: $width, in: 0.0 ... 800.0)
        }
    }
    
    static var previews: some View {
        SubcategoryLayout_Previews()
    }
}
