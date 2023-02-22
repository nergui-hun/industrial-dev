//
//  Post.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import Foundation

public struct Post {
    public let author: String?
    public var description: String
    public let image: String
    public var likes: Int
    public var views: Int

    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

