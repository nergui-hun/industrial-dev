//
//  SceneDelegate.swift
//  Navigation
//
//  Created by M M on 1/31/23.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        UserDefaults.standard.removeObject(forKey: "loginMatch")
        self.mainCoordinator = MainCoordinatorImp(window: window)
        mainCoordinator?.startApplication()
    }
}
