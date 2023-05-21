//
//  TopicLabel.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI
import DiscourseKit

struct TopicLabel: View {
    let topic: Topic
    
    var body: some View {
        Text(topic.title)
    }
}

struct TopicLabel_Previews: PreviewProvider {
    static var previews: some View {
        TopicLabel(topic: .test)
    }
}
