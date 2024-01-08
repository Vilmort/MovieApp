//
//  SuggestionsRouter.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import Foundation
import KPNetwork

final class SuggestionsRouter: Router, SuggestionsRouterProtocol {
    func showMovieScreen(_ entity: KPMovieEntity) {
        pushScreen(MovieDetailAssembly(entity: entity).build())
    }
}
