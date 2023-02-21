//
//  MainCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

protocol MainCoordinator {
    
    func startApplication()
}

final class MainCoordinatorImp: MainCoordinator {

    let window: UIWindow?
    private let tabbar = MainTabBarViewController()
    private let feedVC = FeedViewController()
    private let profileVC = ProfileViewController()

    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func startApplication() {

        let loginCoordinator = LoginCoordinator(window: self.window, parentCoordinator: self)
        let loginVC = loginCoordinator.navCon

        switch UserDefaults.standard.bool(forKey: "loginMatch") {

        case true:
            loginCoordinator.openProfile()
        case false:
            tabbar.viewControllers = [loginVC]
            loginCoordinator.openLoginVC()
        }
        self.window?.rootViewController = tabbar
    }

    func setupTabbar() {
        tabbar.setupView()
        tabbar.viewControllers = [feedVC, profileVC]
    }
}
