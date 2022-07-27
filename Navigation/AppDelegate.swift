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

        
        // MARK: Feed VC
        let feedVC = FeedViewController()
        let feedNavC = UINavigationController(rootViewController: feedVC)
        feedNavC.setViewControllers([feedVC], animated: true)
        feedNavC.tabBarItem.image = UIImage(systemName: "house.fill")


        // MARK: Login VC
        let loginVC = LogInViewController()
        let loginNavC = UINavigationController(rootViewController: loginVC)
        loginNavC.setViewControllers([loginVC], animated: true)
        loginNavC.tabBarItem.image = UIImage(systemName: "person.fill")

        let factory = MyLoginFactory()
        loginVC.delegate = factory.getLoginInspector()


        // MARK: Tab Bar
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController
        tabBarController.viewControllers = [feedNavC, loginNavC]
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.isTranslucent = false

       

        
        self.window?.makeKeyAndVisible()
        return true
    }
    
}

