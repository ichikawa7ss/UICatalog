//
//  AppDelegate.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = CatalogMenuViewController.instantiate()
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()

        return true
    }
}
