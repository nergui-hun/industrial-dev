//
//  Post.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import Foundation

public struct Post {
    public let id: UInt
    public let author: String
    public var postText: String
    public let image: String
    public var likes: UInt
    public var views: UInt

    public init(id: UInt, author: String, postText: String, image: String, likes: UInt, views: UInt) {
        self.id = id
        self.author = author
        self.postText = postText
        self.image = image
        self.likes = likes
        self.views = views
    }
}

