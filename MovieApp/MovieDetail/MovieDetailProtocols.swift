//
//  MovieDetailProtocols.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit

protocol MovieDetailControllerProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: MovieDetailController.Model)
    func showShare(_ shares: [(image: UIImage, action: () -> Void)])
    func configureWishlistButton(_ isInWishlist: Bool)
}

protocol MovieDetailPresenterProtocol: AnyObject {
    func activate()
    func didTapWishlistButton()
}

protocol MovieDetailRouterProtocol: AnyObject {
    func showMovie(_ id: Int)
}
