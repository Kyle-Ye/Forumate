//
//  TopicDetailWindowModel.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import DiscourseKit
import Foundation
import SwiftData

struct TopicDetailWindowModel: Codable, Hashable {
    let topic: Topic
    let communityID: PersistentIdentifier
}
