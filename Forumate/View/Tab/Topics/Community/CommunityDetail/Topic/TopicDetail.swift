//
//  TopicDetail.swift
//  Forumate
//
//  Created by Kyle on 2023/5/22.
//

import SwiftUI
import DiscourseKit

struct TopicDetail: View {
    let topic: Topic
    var body: some View {
        Text(topic.title)
    }
}

struct TopicDetail_Previews: PreviewProvider {
    static var previews: some View {
        TopicDetail(topic: .test)
    }
}
