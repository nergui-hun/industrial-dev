//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class LoginCoordinator {
    func redirectProfile(navCon: UINavigationController?, coordinator: LoginCoordinator) {
        //let viewModel = LoginVM()
        let vc = ProfileViewController()
        navCon?.pushViewController(vc, animated: true)
    }
}
