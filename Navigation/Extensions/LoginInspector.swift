//
//  LoginInspector.swift
//  Navigation
//
//  Created by M M on 7/23/22.
//

import Foundation

final class LoginInspector: LoginViewControllerDelegate {
    
    func matchCheck(login: String, password: String) -> Bool {
        let data = Checker.shared.doMatch(login: login, password: password)
        if data {
            return true
        } else {
            return false
        }
    }
}
