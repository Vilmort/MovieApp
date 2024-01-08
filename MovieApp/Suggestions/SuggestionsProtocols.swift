//
//  SuggestionsProtocols.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import Foundation
import KPNetwork

protocol SuggestionsViewProtocol: AnyObject, LoadingPresenting, ErrorPresenting {
    func update(with model: SuggestionsController.Model)
    func showSuggestion(with model: SuggestionsController.SuggestionModel)
}

protocol SuggestionsPresenterProtocol: AnyObject {
    func activate()
    func didTapSuggestion()
}

protocol SuggestionsRouterProtocol: AnyObject {
    func showMovieScreen(_ entity: KPMovieEntity)
}
