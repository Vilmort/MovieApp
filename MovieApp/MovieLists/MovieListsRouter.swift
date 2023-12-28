//
//  MovieListsRouter.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit

final class MovieListsRouter: Router, MovieListsRouterProtocol {
    func showMovieList(title: String, slug: String) {
        pushScreen(
            MovieListAssembly(
                title: title,
                slug: slug,
                genre: nil
            ).build()
        )
    }
}
