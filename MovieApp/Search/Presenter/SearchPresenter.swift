//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import Foundation

//MARK: - Protocols
protocol SearchViewProtocol: AnyObject {

}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?

   required init(view: SearchViewProtocol) {
        self.view = view
    }
   
}
