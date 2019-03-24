//
//  AppDelegate.swift
//  FlagRecognizer
//
//  Created by Josip Rezic on 24/03/2019.
//  Copyright © 2019 Josip Rezic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //
    // MARK: - VARIABLES
    //
    
    var window: UIWindow?

    //
    // MARK: - METHODS
    //
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ViewController.fromStoryboard())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
 
}

