//
// Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import NotificationCenter

extension AppDelegate {
    func requestNotifications() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if didAllow {
                print("User has allowed notifications")
            } else {
                print("User has declined notifications")
            }
        }
    }

    func scheduleDailyNotification() {

        // notification
        let content = UNMutableNotificationContent()
        content.title = "А кто сегодня отписался от тебя?"
        content.body = "Не забывай следить за теми, кто отписывается от тебя, это происходит постоянно, будь в курсе!"
        content.sound = .default
        content.badge = 1

        // date formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        // trigger
        let date = formatter.date(from: "2020/01/01 21:00")!
        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        // sending
        let identifier = "LocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}