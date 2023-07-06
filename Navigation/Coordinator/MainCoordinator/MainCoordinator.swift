//
//  MainCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        MainTabBarViewController()
    }
}
