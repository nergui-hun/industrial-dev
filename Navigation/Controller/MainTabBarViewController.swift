//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class MainTabBarViewController: UITabBarController {

    private let feedVC = NavFactory(navCon: UINavigationController(), tab: .feed)
    private let profileVC = NavFactory(navCon: UINavigationController(), tab: .profile)
    private let savedVC = NavFactory(navCon: UINavigationController(), tab: .saved)

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        setupView()
    }

    private func setupView() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false

        feedVC.navCon.tabBarItem.image = UIImage(systemName: "house.fill")
        profileVC.navCon.tabBarItem.image = UIImage(systemName: "person.fill")
        savedVC.navCon.tabBarItem.image = UIImage(systemName: "bookmark.fill")
    }

    private func setControllers() {
        viewControllers = [
            feedVC.navCon,
            profileVC.navCon,
            savedVC.navCon
        ]
    }
}
