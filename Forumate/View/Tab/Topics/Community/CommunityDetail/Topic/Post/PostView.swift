//
//  PostView.swift
//  Forumate
//
//  Created by Kyle on 2023/6/3.
//

import DiscourseKit
import SwiftUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        Text(post.cooked)
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: )
//    }
//}
