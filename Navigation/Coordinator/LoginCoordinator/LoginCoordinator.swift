//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(email: String, pass: String, vc: LogInViewController)
    func signUp()
}

final class LoginCoordinator: LoginViewControllerDelegate {

    private var checkerService = CheckerService.shared

    func checkCredentials(email: String, pass: String, vc: LogInViewController) {
        checkerService.checkCredentials(email: email, pass: pass, vc: vc)
    }

    func signUp() {
        print("\n\n\n\nLogin coord\n\n\n\n")
    }

    func redirectProfile(vc: UIViewController, navCon: UINavigationController?, coordinator: LoginCoordinator) {
        navCon?.pushViewController(vc, animated: true)
    }
}

