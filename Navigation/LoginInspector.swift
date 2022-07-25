//
//  LoginInspector.swift
//  Navigation
//
//  Created by M M on 7/23/22.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func matchCheck(login: String, password: String) -> Bool {
        let data = Checker.shared.doMatch(login: login, password: password)
        if data {
            print("Correct!")
            return true
        } else {
            print("The user doesn't exist or the password is wrong")
            return false
        }
    }
}
