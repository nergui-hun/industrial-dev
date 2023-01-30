//
//  CheckerService.swift
//  Navigation
//
//  Created by M M on 10/29/22.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, pass: String, vc: LogInViewController)
    func signUp()
}

final class CheckerService: CheckerServiceProtocol {
    static let shared = CheckerService()

    private init() {}

    func checkCredentials(email: String, pass: String, vc: LogInViewController) {
        let coordinator = LoginCoordinator()
        
        Auth.auth().signIn(withEmail: email, password: pass) {
            result, error in
            if let result = result, error == nil {

                    vc.viewModel.changeState(.viewReady)

            } else {
                if error?.localizedDescription == "The password is invalid or the user does not have a password." {
                    vc.errorLabel.text = "Wrong password"
                } else if error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    coordinator.redirectProfile(vc: RegisterViewController(), navCon: vc.navigationController, coordinator: coordinator)
                } else {
                    let myAlertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default)

                    myAlertController.addAction(action)
                    vc.present(myAlertController, animated: true)
                }
            }
        }

    }

    func signUp() {
        print(#function)
    }

    
}
