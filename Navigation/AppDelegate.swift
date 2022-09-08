//
//  AppDelegate.swift
//  Navigation
//
//  Created by M M on 3/19/22.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let mainCoordinator = MainCoordinatorImp()
        self.window?.rootViewController = mainCoordinator.startApplication()

        DispatchQueue.global().async {
                NetworkManager.getTitle()
                NetworkManager.getPlanetData()
        }
        return true
    }
    
}

