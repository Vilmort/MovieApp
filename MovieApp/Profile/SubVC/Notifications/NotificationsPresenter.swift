//
//  NotificationsPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation


protocol NotificationsVCProtocol: AnyObject {
    
}

protocol NotificationsPresenterProtocol {
    init(view: NotificationsVCProtocol)
}

// MARK: - NotificationsPresenter
final class NotificationsPresenter: NotificationsPresenterProtocol {
    
    private weak var view: NotificationsVCProtocol?
    
    init(view: NotificationsVCProtocol) {
        self.view = view
    }

}
