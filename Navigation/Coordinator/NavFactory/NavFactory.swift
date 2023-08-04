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
        case profile
        case saved
    }

    let navCon: UINavigationController
    let tab: Tab
    let profileVM = ProfileVM()

    init(navCon: UINavigationController, tab: Tab) {
        self.navCon = navCon
        self.tab = tab
        startModule()
    }

    func startModule() {

        let controller: UIViewController

        switch tab {
        case .feed:
            controller = FeedViewController()
            navCon.tabBarItem.title = "Feed"
        case .profile:
            controller = ProfileViewController(viewModel: profileVM)
            navCon.tabBarItem.title = "Profile"
        case .saved:
            controller = SavedViewController()
            navCon.tabBarItem.title = "Saved"
        }

        navCon.setViewControllers([controller], animated: true)
    }
}
