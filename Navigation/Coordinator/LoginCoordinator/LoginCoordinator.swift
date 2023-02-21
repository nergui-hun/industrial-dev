//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

/*protocol LoginViewControllerDelegate: AnyObject {
    func login()
}*/

final class LoginCoordinator {

    let parentCoordinator: MainCoordinatorImp
    let profileVC = ProfileViewController()
    let navCon: UINavigationController
    let window: UIWindow?

    init(window: UIWindow?, parentCoordinator: MainCoordinatorImp) {
        self.navCon = .init()
        self.window = window
        self.parentCoordinator = parentCoordinator
    }

    func openLoginVC() {
        let loginVM = LoginVM()
        let controller = LogInViewController(coordinator: self, viewModel: loginVM)
        self.navCon.pushViewController(controller, animated: true)
    }

    func openProfile() {
        parentCoordinator.setupTabbar()
        self.navCon.pushViewController(profileVC, animated: true)
    }


    func redirectProfile(navCon: UINavigationController?, coordinator: LoginCoordinator) {
        window?.rootViewController = MainTabBarViewController()
        navCon?.pushViewController(profileVC, animated: true)
    }
}
