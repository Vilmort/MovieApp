//
//  HomeProtocols.swift
//  MovieApp
//
//  Created by Victor Rubenko on 10.01.2024.
//

import Foundation

protocol HomeViewProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: HomeController.Model)
}

protocol HomePresenterProtocol: AnyObject {
    func activate()
}

protocol HomeRouterProtocol: AnyObject {
    func showMovieDetail(_ id: Int)
    func showMovieList(_ genre: String)
    func showCategories()
}
