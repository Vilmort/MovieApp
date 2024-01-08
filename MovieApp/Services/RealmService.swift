//
//  RealmService.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func saveUser(_ user: User)
    func fetchUser() -> User?
    func isUserWithLoginExist(withLogin login: String) -> Bool
    func isUserWithEmailExist(withEmail email: String) -> Bool 
}

final class RealmService: RealmServiceProtocol {
    static let shared = RealmService()
    private let realm = try! Realm()

    func saveUser(_ user: User) {
        do {
            try realm.write {
                realm.add(user)     
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUser() -> User? {
        realm.objects(User.self).last
    }
    
    func isUserWithLoginExist(withLogin login: String) -> Bool {
        let user = realm.objects(User.self).filter("login == %@", login).first
        return user != nil
    }
    
    func isUserWithEmailExist(withEmail email: String) -> Bool {
        let user = realm.objects(User.self).filter("email == %@", email).first
        return user != nil
    }
    
    
}
