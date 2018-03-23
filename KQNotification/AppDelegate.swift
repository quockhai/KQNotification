//
//  AppDelegate.swift
//  KQNotification
//
//  Created by Quoc Khai on 3/23/18.
//  Copyright © 2018 Quoc Khai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        KQNotification.shared.registerNotification(withOptions: [.alert, .badge, .sound], completion: nil)
        
        return true
    }
}

