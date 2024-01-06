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
    init(view: ProfileViewProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
   
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
}
