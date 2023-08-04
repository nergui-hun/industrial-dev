//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class ProfileCoordinator {

    // MARK: - Values

    let parentCoordinator: AppCoordinator
    let profileVM = ProfileVM()
    lazy var profileVC = ProfileViewController(viewModel: self.profileVM)
    let navCon: UINavigationController
    let window: UIWindow?

    init(window: UIWindow?, parentCoordinator: AppCoordinator) {
        self.navCon = .init()
        self.window = window
        self.parentCoordinator = parentCoordinator
    }

    func openProfile() {
        self.navCon.pushViewController(profileVC, animated: true)
    }


    //coordinator?
    func redirectProfile(navCon: UINavigationController?, coordinator: ProfileCoordinator) {
        window?.rootViewController = MainTabBarViewController()
        navCon?.pushViewController(profileVC, animated: true)
    }
}
