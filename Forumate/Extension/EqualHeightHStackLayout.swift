//
//  EqualHeightHStackLayout.swift
//  Forumate
//
//  Created by Kyle on 2023/6/18.
//

import os.log
import SwiftUI

/// Only support 2 elements
struct EqualHeightHStackLayout: Layout {
    private let logger = Logger(subsystem: "top.kyleye.forumate", category: "EqualHeightHStackLayout")
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        logger.trace("placeSubviews start")
        precondition(subviews.count == 2)
        logger.trace("proposal \(proposal.debugDescription)")
        logger.trace("bounds \(bounds.debugDescription)")
        let size = subviews[1].sizeThatFits(proposal)
        let height = size.height
        let spacing = subviews[1].spacing.distance(to: subviews[0].spacing, along: .horizontal)
        let size0 = subviews[0].sizeThatFits(ProposedViewSize(width: height, height: height))
        logger.trace("size \(bounds.debugDescription)")
        logger.trace("spacing \(spacing.description)")
        logger.trace("size0 \(size0.debugDescription)")
        if let proposalWidth = proposal.width,
           proposalWidth - size0.width >= 0 {
            var point = bounds.origin
            subviews[0].place(at: point, proposal: ProposedViewSize(width: size0.width, height: size0.height))
            point.x += size0.width + spacing
            if proposalWidth - size0.width - spacing >= 0 {
                let size1 = subviews[1].sizeThatFits(ProposedViewSize(
                    width: proposalWidth - size0.width - spacing,
                    height: height
                ))
                logger.trace("size1 \(size1.debugDescription)")
                subviews[1].place(at: point, proposal: ProposedViewSize(width: size1.width, height: size1.height))
            } else {
                subviews[1].place(at: bounds.origin, proposal: .init(width: 0, height: 0))
            }
        } else {
            subviews[0].place(at: bounds.origin, proposal: .init(width: 0, height: 0))
            subviews[1].place(at: bounds.origin, proposal: proposal)
        }
        logger.trace("placeSubviews end")
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        logger.trace("sizeThatFits start")
        precondition(subviews.count == 2)
        let size = subviews[1].sizeThatFits(proposal)
        let height = size.height
        let spacing = subviews[1].spacing.distance(to: subviews[0].spacing, along: .horizontal)
        let size0 = subviews[0].sizeThatFits(ProposedViewSize(width: height, height: height))
        
        let width: Double
        if let proposalWidth = proposal.width,
           proposalWidth - size0.width >= 0 {
            if proposalWidth - size0.width - spacing >= 0 {
                let size1 = subviews[1].sizeThatFits(ProposedViewSize(
                    width: proposalWidth - size0.width - spacing,
                    height: height
                ))
                logger.log("size1 \(size1.debugDescription)")
                width = size0.width + spacing + size1.width
            } else {
                width = size0.width
            }
        } else {
            width = size.width
        }
        logger.trace("size \(size.debugDescription)")
        logger.trace("size0 \(size0.debugDescription)")
        logger.trace("spacing \(spacing.description)")
        logger.trace("proposal \(proposal.debugDescription)")
        logger.trace("sizeThatFits \(CGSize(width: width, height: height).debugDescription)")
        logger.trace("sizeThatFits end")
        return CGSize(width: width, height: height)
    }
}

extension ProposedViewSize: CustomDebugStringConvertible {
    public var debugDescription: String { "(\(width.debugDescription), \(height.debugDescription))" }
}

struct EqualHeightHStackLayout_Preview: View {
    @State var width: CGFloat = 62

    var body: some View {
        VStack(alignment: .leading) {
            EqualHeightHStackLayout {
                AsyncImage(url: nil) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(verbatim: "Test").font(.title)
                    Text(String(repeating: "Long", count: 10))
                }
                .lineLimit(1)
            }
            .border(.red, width: 1)
            .frame(width: width)
            Slider(value: $width, in: 0.0 ... 400.0, step: 1.0)
            Text(width.description)
        }
    }
}

#Preview {
    EqualHeightHStackLayout_Preview()
}
