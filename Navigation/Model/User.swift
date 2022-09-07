//
//  User.swift
//  Navigation
//
//  Created by M M on 9/2/22.
//

import Foundation

struct User: Encodable, Decodable {
    let userId: Int
    let id: Int
    var title: String
    var completed: Bool

    
}

