//
//  AppDelegate.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let loginVC = LoginVC()
        let navVC = UINavigationController(rootViewController: loginVC)
        loginVC.title = "Login Page"
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }


}

