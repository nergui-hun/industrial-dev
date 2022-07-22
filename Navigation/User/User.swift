//
//  User.swift
//  Navigation
//
//  Created by M M on 7/22/22.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol UserService {
    func showUserInfo(login: String) -> User?
}

// MARK: - User

final class User {
    var login: String?
    var fullName: String?
    var avatar: UIImage?
    var status: String?

    init(login: String?, fullName: String?, avatar: UIImage?, status: String?) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

// MARK: - CurrentUserService

class CurrentUserService: UserService {

    var user = User(login: "login", fullName: "LoginName", avatar: UIImage(named: "1"), status: "Login status")

    func showUserInfo(login: String) -> User? {
        return login == user.login ? user : nil
    }
}

// MARK: - TestUserService

class TestUserService: UserService {
    var user = User(login: "test", fullName: "TestName", avatar: UIImage(named: "2"), status: "Test status")

    func showUserInfo(login: String) -> User? {
        return login == user.login ? user : nil
    }
}

