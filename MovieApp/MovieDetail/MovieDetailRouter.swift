//
//  MovieDetailRouter.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit

final class MovieDetailRouter: Router, MovieDetailRouterProtocol {
    func showMovie(_ id: Int) {
        pushScreen(MovieDetailAssembly(id: id).build())
    }
    
    func showArtist(_ id: Int) {
        presentScreen(ArtistsAssembly(id: id).build())
    }
    
    func showMovieWebview(_ id: Int) {
        guard let url = URL(string: "https://www.kinopoisk.vip/film/\(id)") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
