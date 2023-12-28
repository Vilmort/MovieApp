//
//  MovieListProtocols.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import Foundation

protocol MovieListControllerProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: MovieListController.Model)
}

protocol MovieListPresenterProtocol: AnyObject {
    func activate()
}

protocol MovieListRouterProtocol: AnyObject {
    func showMovie(_ id: Int)
}
