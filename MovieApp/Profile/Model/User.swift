//
//  User.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var image: Data = Data()
    @Persisted var login: String = ""
    @Persisted var email: String = ""
}
