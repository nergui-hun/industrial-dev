//
//  SceneDelegate.swift
//  Navigation
//
//  Created by M M on 2/25/23.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

            guard let scene = (scene as? UIWindowScene) else { return }
            self.window = UIWindow(windowScene: scene)
            self.appCoordinator = AppCoordinator(window: window)
            appCoordinator?.startApp()
        }
}
