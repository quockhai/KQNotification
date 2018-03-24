//
//  KQNotification.swift
//  KQFramework
//
//  Created by Quốc Khải on 3/21/18.
//  Copyright © 2018 Quoc Khai. All rights reserved.
//

import UIKit
import UserNotifications

open class KQNotification: NSObject {
    open static let shared = KQNotification()
    
    open var notificationCenter: UNUserNotificationCenter!
    
    public override init() {
        super.init()
        
        self.notificationCenter = UNUserNotificationCenter.current()
    }
    
    
    
    //MARK: Register & Check Authorization
    open func registerNotification(withOptions options: UNAuthorizationOptions, completion:((_ success: Bool) -> Void)?) {
        self.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                self.requestAuthorization(options: options, completion: { (granted, error) in
                    if error == nil {
                        completion?(granted)
                    } else {
                        completion?(false)
                    }
                })
            } else {
                if (options.contains(.alert) && settings.alertSetting == .disabled) ||
                    (options.contains(.badge) && settings.badgeSetting == .disabled) ||
                    (options.contains(.sound) && settings.soundSetting == .disabled) ||
                    (options.contains(.carPlay) && settings.carPlaySetting == .disabled) {
                    self.requestAuthorization(options: options, completion: { (granted, error) in
                        if error == nil {
                            completion?(granted)
                        } else {
                            completion?(false)
                        }
                    })
                } else {
                    completion?(true)
                }
            }
        }
    }
    
    open func checkAuthorization(completion:@escaping (_ granted: Bool) -> Void) {
        self.notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    open func requestAuthorization(options: UNAuthorizationOptions, completion:@escaping (_ granted: Bool, _ error: Error?) -> Void) {
        self.notificationCenter.requestAuthorization(options: options) { (granted, error) in
            completion(granted, error)
        }
    }
    
    open func getNotificationSettings(completion:@escaping (_ settings: UNNotificationSettings) -> Void) {
        self.notificationCenter.getNotificationSettings { (settings) in
            completion(settings)
        }
    }


    
    //MARK: Managing Delivered Notifications
    open func removeAllDeliveredNotifications() {
        self.notificationCenter.removeAllDeliveredNotifications()
    }
    
    open func removeDeliveredNotifications(notificationsIdentifier: [String]) {
        self.notificationCenter.removeDeliveredNotifications(withIdentifiers: notificationsIdentifier)
    }
    
    open func getDeliveredNotification(completion:@escaping (_ deliveredNotifications: [UNNotification]) -> Void) {
        self.notificationCenter.getDeliveredNotifications { (notifications) in
            completion(notifications)
        }
    }
    
    
    
    //MARK: Managing Pending Requests
    open func removeAllPendingNotificationRequests() {
        self.notificationCenter.removeAllPendingNotificationRequests()
    }
    
    open func removePendingNotifications(requestsIdentifier: [String]) {
        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: requestsIdentifier)
    }
    
    open func getPendingNotificationRequests(completion:@escaping (_ pendingRequests: [UNNotificationRequest]) -> Void) {
        self.notificationCenter.getPendingNotificationRequests { (requests) in
            completion(requests)
        }
    }
}


//MARK: Time Notification
extension KQNotification {
    open func notification(identifier: String, title: String, body: String, after time: Double, completion:((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: triggerTime)
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
    
    open func repeatsNotification(identifier: String, title: String, body: String, after time: Double, completion: ((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: triggerTime)
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
    
    open func actionsNotification(identifier: String, title: String, body: String, actions: [UNNotificationAction], after time: Double, repeats: Bool, completion: ((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let categoryIdentifier = "\(identifier)Category"
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: actions, intentIdentifiers: [], options: [])
        content.categoryIdentifier = categoryIdentifier
        
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: triggerTime)
        
        self.notificationCenter.setNotificationCategories([category])
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })  
    }
}



//MARK: Daily Notification
extension KQNotification {
    open func dailyNotification(identifier: String, title: String, body: String, date: Date, completion:((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let trigger = Calendar.current.dateComponents([.hour, .minute, .second,], from: date)
        let dailyTrigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dailyTrigger)
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Daily notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
    
    open func dailyActionsNotification(identifier: String, title: String, body: String, actions: [UNNotificationAction], date: Date, completion:((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let categoryIdentifier = "\(identifier)Category"
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: actions, intentIdentifiers: [], options: [])
        content.categoryIdentifier = categoryIdentifier
        
        let trigger = Calendar.current.dateComponents([.hour, .minute, .second,], from: date)
        let dailyTrigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dailyTrigger)
        
        self.notificationCenter.setNotificationCategories([category])
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Daily notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
}



//MARK: Weekly Notification
extension KQNotification {
    open func weeklyNotification(identifier: String, title: String, body: String, date: Date, completion:((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let trigger = Calendar.current.dateComponents([.weekday, .hour, .minute, .second,], from: date)
        let dailyTrigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dailyTrigger)
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Weekly notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
    
    open func weeklyActionsNotification(identifier: String, title: String, body: String, actions: [UNNotificationAction], date: Date, completion:((_ success: Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        

        let categoryIdentifier = "\(identifier)Category"
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: actions, intentIdentifiers: [], options: [])
        content.categoryIdentifier = categoryIdentifier
        
        let trigger = Calendar.current.dateComponents([.weekday, .hour, .minute, .second,], from: date)
        let dailyTrigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dailyTrigger)
        
        self.notificationCenter.setNotificationCategories([category])
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("[KQNotification] Weekly notification error: \(error.localizedDescription)")
                completion?(false)
            } else {
                completion?(true)
            }
        })
    }
}
