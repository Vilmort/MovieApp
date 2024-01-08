//
//  SuggestionsPresenter.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import Foundation
import KPNetwork

final class SuggestionsPresenter: SuggestionsPresenterProtocol {
    
    weak var view: SuggestionsViewProtocol!
    var router: SuggestionsRouterProtocol?
    
    private let networkService: KPNetworkClient
    
    private var suggestions = [8124] + [621, 391755, 8222, 471, 48162, 430, 707, 77331].shuffled()
    private var suggestion: Int?
    
    init(networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.networkService = networkService
    }
    
    func activate() {
        
    }
    
    func didTapSuggestion() {
        view?.showLoading()
        Task {
            await loadSuggestion()
        }
    }
    
    func loadSuggestion(_ suggestion: Int? = nil) async {
        Task {
            guard let suggestionId = suggestion ?? suggestions.popLast() else {
                await showNoSuggestionError()
                return
            }
            let result = await networkService.sendRequest(request: KPMovieRequest(id: suggestionId))
            switch result {
            case .success(let response):
                let year: String = {
                    guard let year = response.year else {
                        return ""
                    }
                    return String(year)
                }()
                await MainActor.run {
                    view?.showSuggestion(
                        with: .init(
                            imageURL: URL(string: response.poster?.previewUrl ?? ""),
                            title: response.name ?? "",
                            subtitle: year,
                            openSuggestion: {
                                [weak self] in
                                
                                self?.router?.showMovieScreen(response)
                            }
                        )
                    )
                    view?.hideLoading()
                }
            case .failure:
                await showError()
            }
        }
    }
    
    @MainActor
    private func showError() async {
        view?.hideLoading()
        view?.showError(
            "Не получилось загрузить рекомендацию",
            message: "Попробуйте еще раз",
            actionTitle: "Обновить",
            action: {
                [weak self] stub in
                
                stub.removeFromSuperview()
                Task {
                    await self?.loadSuggestion(self?.suggestion)
                }
            }
        )
    }
    
    @MainActor
    private func showNoSuggestionError() async {
        view?.hideLoading()
        view?.showError(
            "Вы посмотрели все рекомендации",
            message: "Попробуйте позже",
            actionTitle: "Хорошо",
            action: {
                stub in
                
                stub.removeFromSuperview()
            }
        )
    }
}
