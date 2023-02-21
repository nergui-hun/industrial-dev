//
//  LoginData.swift
//  Navigation
//
//  Created by M M on 2/7/23.
//

import Foundation
import RealmSwift

final class UserData: Object {
    //@Persisted var id: ObjectId
    @Persisted(primaryKey: true) var email: String = ""
    @Persisted var password: String = ""
    @Persisted var name: String = ""
    @Persisted var lastname: String = ""
}
