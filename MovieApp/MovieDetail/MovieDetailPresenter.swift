//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Victor Rubenko on 30.12.2023.
//

import Foundation
import KPNetwork

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailController?
    var router: MovieDetailRouter?
    
    private let id: Int
    private let networkService: KPNetworkClient
    
    init(_ id: Int, networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.id = id
        self.networkService = networkService
    }
    
    func activate() {
        Task {
            await loadData()
        }
    }
    
    @MainActor
    private func loadData() async {
        view?.showLoading()
        let result = await networkService.sendRequest(request: KPMovieRequest(id: id))
        switch result {
        case .success(let response):
            updateUI(response)
        case .failure(let error):
            print(error)
            showError()
        }
        view?.hideLoading()
    }
    
    private func updateUI(_ model: KPMovieEntity) {
        view?.update(
            with: .init(
                poster: URL(string: model.poster?.url ?? ""),
                name: model.name ?? "",
                year: model.year,
                length: model.movieLength,
                genre: model.genres?.first?.name,
                rating: model.rating?.kp,
                plot: model.description,
                cast: (model.persons ?? []).map {
                    .init(imageURL: URL(string: $0.photo ?? ""), name: $0.name, role: $0.profession)
                },
                trailerAction: nil,
                shareAction: nil
            )
        )
        view?.hideLoading()
    }
    
    private func showError() {
        view?.showError(
            "Не получилось загрузить фильм",
            message: "Попробуйте еще раз",
            actionTitle: "Обновить",
            action: {
                [weak self] stub in
                
                stub.removeFromSuperview()
                self?.activate()
            }
        )
    }
}
