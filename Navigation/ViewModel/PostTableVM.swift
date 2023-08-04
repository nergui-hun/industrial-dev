//
//  PostTableVM.swift
//  Navigation
//
//  Created by M M on 3/5/23.
//

import Foundation
import StorageService

struct PostTableVM {

    var post: Post

    var postID: UInt {
        post.id
    }

    var author: String {
        post.author
    }

    var postText: String {
        post.postText
    }

    var image: String {
        post.image
    }

    var likes: UInt {
        post.likes
    }

    var views: UInt {
        post.views
    }
}
