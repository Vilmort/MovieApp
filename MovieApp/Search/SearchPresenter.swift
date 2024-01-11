//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import Foundation
import KPNetwork

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol!
    var router: SearchRouterProtocol?
    
    private let networkService: KPNetworkClient
    private var showKeyboardOnStart = false
    
    init(networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.networkService = networkService
    }
    
    func activate() {
        if showKeyboardOnStart {
            showKeyboardOnStart = false
            view?.showKeyboard()
        }
        view.update(with: .init(movies: [], emptyQuery: true))
    }
    
    func didEnterQuery(_ text: String?) {
        view?.hideError()
        guard let text, !text.isEmpty else {
            view?.update(with: .init(movies: [], emptyQuery: true))
            return
        }
        Task {
            await sendSearchRequest(text)
        }
    }
    
    func setNeedsKeyboard() {
        showKeyboardOnStart = true
    }
    
    @MainActor
    func sendSearchRequest(_ query: String) async {
        view?.showLoading()
        switch await networkService.sendRequest(request: KPMovieSearchTitleRequest(limit: 250, query: query)) {
        case .success(let response):
            view?.hideLoading()
            view?.update(
                with: .init(
                    movies: response.docs.filter { $0.poster?.previewUrl != nil }.map {
                        movie in
                        
                        return .init(
                            model: .init(
                                imageURL: URL(string: movie.poster?.previewUrl ?? ""),
                                name: movie.name ?? "",
                                year: movie.year,
                                lenght: movie.movieLength,
                                genre: (movie.genres ?? []).compactMap { $0.name }.joined(separator: ", "),
                                rating: movie.rating?.kp,
                                ageRating: movie.ratingMpaa?.uppercased()
                            ),
                            didSelect: {
                                [weak self] in
                                
                                self?.router?.showMovieDetail(movie.id)
                            }
                        )
                    },
                    emptyQuery: false
                )
            )
        case .failure:
            view?.hideLoading()
            view?.showError(
                "Не удалось получить список фильмов",
                message: "Попробуйте еще раз",
                actionTitle: "Обновить",
                action: {
                    [weak self] stub in
                    
                    stub.removeFromSuperview()
                    Task {
                        await self?.sendSearchRequest(query)
                    }
                }
            )
        }
    }
}
