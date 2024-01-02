//
//  MovieListRouter.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class MovieListRouter: Router, MovieListRouterProtocol {
    func showMovie(_ id: Int) {
        pushScreen(MovieDetailAssembly(id: id).build())
    }
}
