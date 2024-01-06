//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import Foundation

protocol HomeViewProtocol: AnyObject {

}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol)
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
   
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
}
