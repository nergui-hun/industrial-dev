//
//  NavFactory.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class NavFactory {
    enum Tab {
        case feed
        case login
    }

    let navCon: UINavigationController
    let tab: Tab

    init(navCon: UINavigationController, tab: Tab) {
        self.navCon = navCon
        self.tab = tab
        startModule()
    }

    func startModule() {
        switch tab {
        case .feed:
            let controller = FeedViewController()
            navCon.tabBarItem.title = "Feed"
            navCon.setViewControllers([controller], animated: true)
        case .login:
            let loginCoordinator = LoginCoordinator()
            let loginVM = LoginVM()
            let controller = LogInViewController(coordinator: loginCoordinator, viewModel: loginVM)
            navCon.tabBarItem.title = "Profile"
            navCon.setViewControllers([controller], animated: true)
        }
    }
}
