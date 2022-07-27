//
//  Checker.swift
//  Navigation
//
//  Created by M M on 7/23/22.
//

import Foundation

// MARK: - Protocols
protocol LoginViewControllerDelegate {
    func matchCheck(login: String, password: String) -> Bool
}


final class Checker {

    // MARK: - Variables

    static let shared = Checker()
    private let login = "Mary"
    private let password = "pswd"

    // MARK: - init

    private init() {}


    // MARK: - Methods

    func doMatch(login: String, password: String) -> Bool {
        self.login == login && self.password == password
    }
}
