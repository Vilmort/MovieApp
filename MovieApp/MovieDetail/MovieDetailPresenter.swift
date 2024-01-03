//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import Foundation
import KPNetwork

private typealias Model = MovieDetailController.Model

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailController?
    var router: MovieDetailRouter?
    
    private let id: Int
    private let networkService: KPNetworkClient
    private let shareService: ShareService = .shared
    private var imagesResponse: KPImagesEntity?
    
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
        async let movie = await networkService.sendRequest(request: KPMovieRequest(id: id))
        async let images = await networkService.sendRequest(request: KPImagesRequest(id: id, limit: 15))
        let result = (await movie, await images)
        
        imagesResponse = try? result.1.get()
        
        switch result.0 {
        case .success(let response):
            updateUI(response)
        case .failure(let error):
            print(error)
            showError()
        }
        
        view?.hideLoading()
    }
    
    private func updateUI(_ model: KPMovieEntity) {
        let cast: [Model.CastMember] = (model.persons ?? []).map {
            .init(imageURL: URL(string: $0.photo ?? ""), name: $0.name, role: $0.profession)
        }
        let facts: [Model.Fact] = (model.facts ?? []).map { .init(text: $0.value?.stripHTML() ?? "", spoiler: $0.spoiler ?? true) }
        let videos = Array(Set((model.videos?.trailers ?? []).compactMap { $0.url }))
        let similarMovies: [Model.SimilarMovie] = (model.similarMovies ?? []).map {
            movie in
            
            .init(
                imageURL: URL(string: movie.poster?.previewUrl ?? ""),
                name: movie.name ?? "",
                didSelectHandler: {
                    [weak self] in
                    
                    self?.router?.showMovie(movie.id)
                }
            )
        }
        let images: [URL] = (imagesResponse?.docs ?? []).compactMap { URL(string: $0.previewUrl ?? "") }
        
        view?.update(
            with: .init(
                poster: URL(string: model.poster?.url ?? ""),
                name: model.name ?? "",
                country: model.countries?.first?.name,
                year: model.year,
                length: model.movieLength,
                genre: model.genres?.compactMap { $0.name }.joined(separator: ", "),
                rating: model.rating?.kp,
                age: model.ratingMpaa?.uppercased(),
                plot: model.description,
                cast: cast,
                images: images,
                facts: facts,
                videos: videos,
                similarMovies: similarMovies,
                watchAction: {
                    [weak self] in
                    
                    self?.router?.showMovieWebview(model.id)
                },
                shareAction: {
                    [weak self] in
                    
                    self?.shareService.showShare("https://www.kinopoisk.ru/film/\(model.id)")
                },
                backgroundImage: URL(string: model.backdrop?.url ?? "")
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
