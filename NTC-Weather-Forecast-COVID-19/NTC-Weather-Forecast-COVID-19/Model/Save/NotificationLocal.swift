//
//  NotificationLocal.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/13/21.
//

import Foundation
import UserNotifications

struct NotificationLocal {

    static let shared = NotificationLocal()
    
    private init() { }
    
    func create(title: String, body: String, time: CLong, indexNotification: Int) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("granted: \(granted), error: \(String(describing: error))")
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        var timeInterval = TimeInterval()
        switch indexNotification {
        case 0:
            timeInterval = TimeInterval(time - (3600/2))
        case 1:
            timeInterval = TimeInterval(time - (3600))
        case 2:
            timeInterval = TimeInterval(time - (3600*24))
        default:
            timeInterval = TimeInterval(time - (3600/2))
        }
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: (date) as Date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            print(error as Any)
        }
    }
    
    func clearNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
}
