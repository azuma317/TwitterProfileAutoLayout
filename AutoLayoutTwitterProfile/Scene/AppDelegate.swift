//
//  AppDelegate.swift
//  AutoLayoutTwitterProfile
//
//  Created by Azuma on 2018/12/13.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        window?.rootViewController = nil
        window?.rootViewController = UINavigationController(rootViewController: ContentViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

