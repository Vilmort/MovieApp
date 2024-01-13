//
//  NotificationsPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation


protocol NotificationsVCProtocol: AnyObject {
    func update(isNotificationEnabled: Bool)
    func showNotificationsAlert()
}

protocol NotificationsPresenterProtocol {
    func activate()
    func didSwitchNotifications()
}

// MARK: - NotificationsPresenter
final class NotificationsPresenter: NotificationsPresenterProtocol {
    
    private weak var view: NotificationsVCProtocol?
    private let notificationService: NotificationService
    
    init(
        view: NotificationsVCProtocol,
        notificationService: NotificationService = DIContainer.shared.notificationService
    ) {
        self.view = view
        self.notificationService = notificationService
    }
    
    func activate() {
        view?.update(isNotificationEnabled: notificationService.isWatchNotificationEnabled)
    }
    
    func didSwitchNotifications() {
        if notificationService.isWatchNotificationEnabled {
            notificationService.removeWatchNotification()
        } else {
            notificationService.requestAuthorization {
                [weak self] service, access in
                
                guard access else {
                    DispatchQueue.main.async {
                        self?.view?.update(isNotificationEnabled: false)
                        self?.view?.showNotificationsAlert()
                    }
                    return
                }
                service.makeWatchNotification()
            }
        }
    }

}
