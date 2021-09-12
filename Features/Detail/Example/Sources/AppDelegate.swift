//
//  AppDelegate.swift
//  DetailExample
//
//  Created by Ronan on 12/09/2021.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {

    private let appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appController.start()
        return true
    }
}
