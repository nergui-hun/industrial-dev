//
//  SavedCoordinator.swift
//  Navigation
//
//  Created by M M on 3/3/23.
//

import Foundation
import UIKit

final class SavedCoordinator {

    let savedVC = SavedViewController()
    var navCon: UINavigationController
    let window: UIWindow?

    init(navCon: UINavigationController, window: UIWindow?) {
        self.navCon = .init()
        self.window = window
    }

    func openSavedVC() {
        self.navCon.pushViewController(savedVC, animated: true)
    }
}
