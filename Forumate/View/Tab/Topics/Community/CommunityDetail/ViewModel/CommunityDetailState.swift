//
//  CommunityDetailState.swift
//  Forumate
//
//  Created by Kyle on 2023/5/20.
//

import DiscourseKit
import Foundation
import Combine

typealias Category = DiscourseKit.Category

class CommunityDetailState: ObservableObject {
    init(community: Community) {
        self.community = community
        client = DKClient(baseURL: community.host)
    }
    
    private var client: DKClient
    
    let community: Community
    @Published var categories: [Category]?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchCategories() {
        client.listCategories().sink { _ in
            print("Hello")
        } receiveValue: { categories in
            self.categories = categories
        }.store(in: &cancellables)
    }
}
