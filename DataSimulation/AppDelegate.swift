//
//  AppDelegate.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 跳转到主页
    public func pushToTabBarVC() {
        window!.rootViewController = TabBarVC()
    }
    
    // 跳转到登录界面
    public func pushToLoginVC() {
        window!.rootViewController = ViewController()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        
        
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        
        return true
    }
}

