//
//  AppDelegate.swift
//  wallet
//
//  Created by tgg on 2023/8/6.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // localization
        LocalizationTool.shared.checkLanguage()
        // router
        IVRouter.routerConfiguration()
        // Override point for customization after application launch.
        window = UIWindow()
        IVRouter.to(name: .walletCreate, params: ["window": window])
        
        return true
    }
}
