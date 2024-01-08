//
//  WishlistProtocols.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import Foundation

protocol WishlistControllerProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: WishlistController.Model)
    func removeFromWishlist(_ index: Int)
}

protocol WishlistPresenterProtocol: AnyObject {
    func activate()
}

protocol WishlistRouterProtocol: AnyObject {
    func showMovie(_ id: Int)
}
