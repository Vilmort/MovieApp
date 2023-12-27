//
//  MovieListsRouter.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit

final class MovieListsRouter: Router, MovieListsRouterProtocol {
    func showMovieList(_ slug: String) {
        print("show movie list \(slug)")
    }
}
