//
//  HomeProtocols.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import Foundation

protocol HomeViewProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: HomeController.Model, onlyPopular: Bool)
}

protocol HomePresenterProtocol: AnyObject {
    func activate()
    func didTapWishlistButton()
}

protocol HomeRouterProtocol: AnyObject {
    func showMovieDetail(_ id: Int)
    func showMovieList(title: String, slug: String?, genre: String?)
    func showMovieLists()
    func showWishlist()
}
