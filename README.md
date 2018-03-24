# KQNotification
A Swift class which helps you create local, daily, weekly notifications and add actions for user notification easily.

<p align="center">
<img src="https://img.shields.io/badge/platform-iOS%2010%2B-blue.svg?style=flat" alt="Platform: iOS 10+"/>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift%204-orange.svg?style=flat" alt="Language: Swift 4" /></a>
<img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" /> <br><br>
</p>

## Installation
  [Download](https://github.com/quockhai/KQNotification/archive/master.zip) the project and copy the Source folder into your project and then simply you can use it in any file

#### Cocoapods

```swift
platform :ios, '10.0'
use_frameworks!

pod 'KQNotification'
```

## Usage

### Register
Register notification in didFinishLaunchingWithOptions
``` swift
KQNotification.shared.registerNotification(withOptions: [.alert, .badge, .sound], completion: nil)
```

### Time Notification
``` swift
// Notification after times (seconds)
KQNotification.shared.notification(identifier: "notificationID", title: "KQNotification", body: "Local notification", after: 100, completion: nil)

// Notification after times (seconds) and repeat
KQNotification.shared.repeatsNotification(identifier: "repeatNotificationID", title: "KQNotification", body: "Repeat notification", after: 100, completion: nil)

// Notification after times (seconds) with actions
let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
KQNotification.shared.actionsNotification(identifier: "actionNotificationID", title: "KQNotification", body: "Actions notification", actions: [snoozeAction, deleteAction], after: 60, repeats: true, completion: nil)
```

### Daily Notification
``` swift
// Daily notification
KQNotification.shared.dailyNotification(identifier: "dailyNotificationID", title: "KQNotification", body: "Daily notification", date: Date(), completion: nil)

// Daily notification with actions
let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
KQNotification.shared.dailyActionsNotification(identifier: "dailyNotificationID", title: "KQNotification", body: "Daily notification with actions", actions: [snoozeAction, deleteAction], date: Date(), completion: nil)
```

### Weekly Notification
``` swift
// Daily notification
KQNotification.shared.weeklyNotification(identifier: "weeklyNotificationID", title: "KQNotification", body: "Weekly notification", date: Date(), completion: nil)

// Daily notification with actions
let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
KQNotification.shared.weeklyActionsNotification(identifier: "weeklyNotificationID", title: "KQNotification", body: "Weekly notification with actions", actions: [snoozeAction, deleteAction], date: Date(), completion: nil)
```

### Notification delegate
```swift
// Set delegate
KQNotification.shared.notificationCenter.delegate = self

// Implement UNUserNotificationCenterDelegate
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
```

License
--------


The MIT License (MIT)

Copyright (c) 2015 Quoc Khai

