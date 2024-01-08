//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation


protocol EditProfilePresenterProtocol {
    func saveUserData(user: User)
    func fetchUser()
    func isLoginBooked(login: String) -> Bool
    func isEmailBooked(email: String) -> Bool
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    weak var view: EditProfileViewControllerProtocol?
    private var router: ProfileRouterProtocol?
    private var realmService: RealmServiceProtocol?
    init(view: EditProfileViewControllerProtocol, router: ProfileRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
    }
    
    func saveUserData(user: User) {
        realmService?.saveUser(user)
    }
    
    func fetchUser() {
        if let user = realmService?.fetchUser() {
            view?.fetchUser(user)
        }
    }
    
    func isLoginBooked(login: String) -> Bool {
        guard let realmService else { return false }
        return realmService.isUserWithLoginExist(withLogin: login)
    }
    
    func isEmailBooked(email: String) -> Bool {
        guard let realmService else { return false }
        return realmService.isUserWithEmailExist(withEmail: email)
    }
    
}
