//
//  SearchRouter.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import Foundation

final class SearchRouter: Router, SearchRouterProtocol {
    func showMovieDetail(_ id: Int) {
        pushScreen(MovieDetailAssembly(id: id).build())
    }
}
