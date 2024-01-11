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
    private var hasData = false
    
    init(networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.networkService = networkService
    }
    
    func activate() {
        if showKeyboardOnStart {
            showKeyboardOnStart = false
            view?.showKeyboard()
        }
        guard !hasData else {
            return
        }
        view.update(with: .init(movies: [], artists: [], emptyQuery: true, didSelectMovie: nil))
    }
    
    func didEnterQuery(_ text: String?) {
        hasData = true
        view?.hideError()
        guard let text, !text.isEmpty else {
            view?.update(with: .init(movies: [], artists: [], emptyQuery: true, didSelectMovie: nil))
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
        async let moviesRequest = networkService.sendRequest(request: KPMovieSearchTitleRequest(limit: 250, query: query))
        async let artistsRequest = networkService.sendRequest(request: KPArtistSearchNameRequest(limit: 250, query: query))
        
        let result = await (moviesRequest, artistsRequest)
        let movies = try? result.0.get().docs.filter { $0.poster?.previewUrl != nil }
        let artists = try? result.1.get().docs.filter { $0.photo != nil && $0.photo?.isEmpty == false }
        
        view?.hideLoading()
        
        if movies == nil && artists == nil {
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
            return
        }
        
        view?.update(
            with: .init(
                movies: (movies ?? []).map {
                    .init(
                        id: $0.id,
                        model: .init(
                            imageURL: URL(string: $0.poster?.previewUrl ?? ""),
                            name: $0.name ?? "",
                            year: $0.year,
                            lenght: $0.movieLength,
                            genre: ($0.genres ?? []).compactMap { $0.name }.joined(separator: ", "),
                            rating: $0.rating?.kp,
                            ageRating: $0.ratingMpaa?.uppercased()
                        )
                    )
                },
                artists: (artists ?? []).map {
                    .init(id: $0.id, name: $0.name ?? $0.enName ?? "", imageURL: URL(string: $0.photo ?? ""))
                },
                emptyQuery: false,
                didSelectMovie: {
                    [weak self] id in
                    
                    self?.router?.showMovieDetail(id)
                }
            )
        )
    }
}
