//
//  NotificationService.swift
//  MovieApp
//
//  Created by Victor on 12.01.2024.
//

import Foundation
import NotificationCenter

final class NotificationService {
    
    private enum Constants {
        static let watchNotification = "watch.notification"
        static let watchInterval: Double = 60
    }
    private var _isWatchNotificationEnabled = false
    var isWatchNotificationEnabled: Bool {
        _isWatchNotificationEnabled
    }
    
    init() {
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            requests in
            
            self._isWatchNotificationEnabled = requests.contains { $0.identifier == Constants.watchNotification }
        }
    }
    
    func requestAuthorization(completion: @escaping (NotificationService, Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            [weak self] accessGranted, _ in
            
            guard let self else {
                return
            }
            
            completion(self, accessGranted)
        }
    }
    
    func makeWatchNotification() {
        let content = UNMutableNotificationContent()
        content.title = "NotificationTitle".localized
        content.subtitle = "NotificationMessage".localized
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Constants.watchInterval, repeats: true)
        let request = UNNotificationRequest(identifier: Constants.watchNotification, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        _isWatchNotificationEnabled = true
    }
    
    func removeWatchNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Constants.watchNotification])
        _isWatchNotificationEnabled = false
    }
}
