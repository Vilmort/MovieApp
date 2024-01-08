//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 26.12.2023.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
  
    
}

protocol ProfilePresenterProtocol: AnyObject {
    func showEditProfileVC()
     func showNotificationVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showLanguageVC()
    func fetchUser() -> User?
    init(view: ProfileViewProtocol, router: ProfileRouterProtocol, realmService: RealmServiceProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private var router: ProfileRouterProtocol?
    private var realmService: RealmServiceProtocol?
    
    required init(view: ProfileViewProtocol, router: ProfileRouterProtocol, realmService: RealmServiceProtocol ) {
        self.view = view
        self.router = router
        self.realmService = realmService
    }
   
    func showEditProfileVC() {
        router?.showEditProfile()
    }
    
    func showNotificationVC() {
        router?.showNotifications()
    }
    
    func showPolicyVC() {
        router?.showPrivacyPolicy()
    }
    
    func showAboutUsVC() {
        router?.showAboutUsVC()
    }
    
    func showLanguageVC() {
        router?.showLanguageVC()
    }
    
    func fetchUser() -> User? {
        realmService?.fetchUser()
    }
    
    
}
