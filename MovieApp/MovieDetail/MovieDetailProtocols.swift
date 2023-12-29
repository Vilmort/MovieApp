//
//  MovieDetailProtocols.swift
//  MovieApp
//
//  Created by Victor Rubenko on 30.12.2023.
//

import Foundation

protocol MovieDetailControllerProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: MovieDetailController.Model)
}

protocol MovieDetailPresenterProtocol: AnyObject {
    func activate()
}

protocol MovieDetailRouterProtocol: AnyObject {
    
}
