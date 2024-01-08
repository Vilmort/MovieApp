//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Vanopr on 03.01.2024.
//

import Foundation
import UIKit


protocol ProfileRouterProtocol: AnyObject {
    func showPrivacyPolicy()
    func showEditProfile()
    func showNotifications()
    func showLanguageVC()
    func showAboutUsVC()

}
final class ProfileRouter: Router, ProfileRouterProtocol {
    func showPrivacyPolicy() {
        pushScreen(Builder.createPrivacyPolicyVC())
    }
    
    func showEditProfile() {
        pushScreen(Builder.createEditProfileVC())
    }
        
    func showNotifications() {
        pushScreen(Builder.createNotificationsVC())
    }
    func showLanguageVC() {
        let vc = UINavigationController(rootViewController: Builder.createLanguageVC())
        vc.modalPresentationStyle = .fullScreen
        presentScreen(vc)
    }
    func showAboutUsVC() {
        pushScreen(Builder.createAboutUsVC())
    }
}
