# KQNotification

Local Notification helper written in Swift

### About
KQNotification is a Swift class which helps you create - post local notifications and add action buttons for user notification easily


## Installation
  [Download](https://github.com/quockhai/KQNotification/archive/master.zip) the project and copy the Source folder into your project and then simply you can use it in any file

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

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

