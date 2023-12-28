//
//  MovieListsProtocols.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import Foundation

protocol MovieListsViewProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: MovieListsController.Model)
}

protocol MovieListsPresenterProtocol: AnyObject {
    func activate()
}

protocol MovieListsRouterProtocol: AnyObject {
    func showMovieList(title: String, slug: String)
}
