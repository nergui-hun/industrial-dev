//
//  SavedPostsCellVM.swift
//  Navigation
//
//  Created by M M on 3/1/23.
//

import Foundation

struct SavedPostsCellVM {

    var post: SavedPosts

    var postID: UInt {
        return UInt(post.id)
    }

    var author: String {
        return post.author! //Fatal error: Unexpectedly found nil while unwrapping an Optional value
    }

    var postText: String {
        return post.postText!
    }

    var image: String {
        return post.image!
    }

    var likes: UInt {
        return UInt(post.likes)
    }

    var views: UInt {
        return UInt(post.views)
    }
}
