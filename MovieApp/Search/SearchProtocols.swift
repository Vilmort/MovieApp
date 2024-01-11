//
//  SearchProtocols.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import Foundation

protocol SearchViewProtocol: AnyObject, ErrorPresenting, LoadingPresenting {
    func update(with model: SearchController.Model)
    func showKeyboard()
}

protocol SearchPresenterProtocol: AnyObject {
    func activate()
    func didEnterQuery(_ text: String?)
    func setNeedsKeyboard()
}

protocol SearchRouterProtocol: AnyObject {
    func showMovieDetail(_ id: Int)
}
