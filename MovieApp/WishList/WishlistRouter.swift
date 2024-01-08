//
//  WishlistRouter.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import UIKit

final class WishlistRouter: Router, WishlistRouterProtocol {
    func showMovie(_ id: Int) {
        pushScreen(MovieDetailAssembly(id: id).build())
    }
}
