//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        disableAnimations()
        
        appController.start()
        
        return true
    }
    
    func disableAnimations() {
        let arguments = ProcessInfo.processInfo.arguments
        UIView.setAnimationsEnabled(!arguments.contains("UITesting"))
    }
}
