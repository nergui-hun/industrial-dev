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

    override func viewDidLoad() {
        super.viewDidLoad()
       // setControllers()
        //setupView()
    }

    func setupView() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false

        feedVC.navCon.tabBarItem.image = UIImage(systemName: "house.fill")
        profileVC.navCon.tabBarItem.image = UIImage(systemName: "person.fill")
    }

    /*private func setControllers() {
        viewControllers = [
            feedVC.navCon,
            profileVC.navCon]
    }*/
}
