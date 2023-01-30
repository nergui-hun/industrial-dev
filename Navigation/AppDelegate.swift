//
//  AppDelegate.swift
//  Navigation
//
//  Created by M M on 3/19/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
<<<<<<< Updated upstream
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController
=======
        self.window?.makeKeyAndVisible()

        FirebaseApp.configure()
>>>>>>> Stashed changes
        
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

    func applicationWillTerminate(_ application: UIApplication) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
}

