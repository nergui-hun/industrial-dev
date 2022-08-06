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
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController
        
        let feedViewController = FeedViewController()
        let logInViewController = LogInViewController()
        
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: logInViewController)
        
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.isTranslucent = false
        
        feedNavigationController.setViewControllers([feedViewController], animated: true)
        feedNavigationController.tabBarItem.image = UIImage(systemName: "house.fill")
       
        
        profileNavigationController.setViewControllers([logInViewController], animated: true)
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
}

