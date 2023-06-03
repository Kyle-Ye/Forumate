//
//  TopicDetailWindowModel.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import Foundation
import DiscourseKit

struct TopicDetailWindowModel: Codable, Hashable {
    let topic: Topic
    let community: Community
}
