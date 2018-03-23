//
//  ViewController.swift
//  KQNotification
//
//  Created by Quoc Khai on 3/23/18.
//  Copyright © 2018 Quoc Khai. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Time Notification
        KQNotification.shared.notification(identifier: "notification", title: "KQNotification", body: "Notification after 60s", after: 60, completion: nil)
        
        KQNotification.shared.repeatsNotification(identifier: "repeatNotification", title: "KQNotification", body: "Repeat notification each 300s", after: 300, completion: nil)
        
        
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        KQNotification.shared.actionsNotification(identifier: "actionsNotification", title: "KQNotification", body: "Notification after 100s with actions", actions: [snoozeAction, deleteAction], after: 100, repeats: false, completion: nil)
        
        KQNotification.shared.notificationCenter.delegate = self
        
        /*
        // Daily Notification
        KQNotification.shared.dailyNotification(identifier: "dailyNotification", title: "KQNotification", body: "Daily notification", date: Date(), completion: nil)
        KQNotification.shared.dailyActionsNotification(identifier: "dailyActionsNotification", title: "KQNotification", body: "Daily notification with actions", actions: [snoozeAction, deleteAction], date: Date(), completion: nil)
        
        // Weekly Notification
        KQNotification.shared.weeklyNotification(identifier: "weeklyNotification", title: "KQNotification", body: "Weekly notification", date: Date(), completion: nil)
        KQNotification.shared.weeklyActionsNotification(identifier: "weeklyActionsNotification", title: "KQNotification", body: "Weekly notification with actions", actions: [snoozeAction, deleteAction], date: Date(), completion: nil)
         */
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default action")
            
        case UNNotificationDismissActionIdentifier:
            print("Dismiss action")
            
        case "Snooze":
            print("Snooze")
            
        case "Delete":
            print("Delete")
            
        default:
            print("Unknown action")
            break
            
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

