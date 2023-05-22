//
//  TopicLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import DiscourseKit
import Flow
import SwiftUI

struct TopicLabel: View {
    let topic: Topic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            mainInfo
            authorInfo
            extensionInfo
        }
    }

    var mainInfo: some View {
        HFlow(spacing: 2) {
            if topic.pinned {
                Image(systemName: "pin.fill")
            }
            Text(topic.title)
                .bold()
            ForEach(topic.tags, id: \.self) { tag in
                TagView(tag)
            }
        }
    }
    
    var authorInfo: some View {
        HStack {
            Text("by")
        }
        .font(.footnote)
    }

    var extensionInfo: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "message")
                Text(topic.postsCount.description)
            }
            HStack(spacing: 2) {
                Image(systemName: "calendar.badge.clock")
                HStack(spacing: 5) {
                    Text(topic.lastPostedAt, style: .relative)
                    Text("·")
                    Text(topic.lastPosterUsername)
                }
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

struct TopicLabel_Previews: PreviewProvider {
    static var previews: some View {
        TopicLabel(topic: .test)
    }
}
