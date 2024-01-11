//
//  ArtistProtocols.swift
//  MovieApp
//
//  Created by Victor on 12.01.2024.
//

import Foundation

protocol ArtistViewProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: ArtistController.Model)
}

protocol ArtistPresenterProtocol: AnyObject {
    func activate()
}

protocol ArtistRouterProtocol: AnyObject {
    
}
