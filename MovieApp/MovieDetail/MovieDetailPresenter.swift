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
    private var movieResponse: KPMovieEntity?
    private let networkService: KPNetworkClient
    private let shareService: ShareService
    private let persistentService: PersistentServiceProtocol
    private var imagesResponse: KPImagesEntity?
    
    private var isInWishlist: Bool {
        persistentService.getWishlist().contains(where: { $0.id == id })
    }
    
    init(
        _ id: Int,
        networkService: KPNetworkClient = DIContainer.shared.networkService,
        persistentService: PersistentServiceProtocol = DIContainer.shared.persistentService,
        shareService: ShareService = DIContainer.shared.shareService
    ) {
        self.id = id
        self.networkService = networkService
        self.persistentService = persistentService
        self.shareService = shareService
    }
    
    convenience init(
        entity: KPMovieEntity,
        networkService: KPNetworkClient = DIContainer.shared.networkService,
        persistentService: PersistentServiceProtocol = DIContainer.shared.persistentService,
        shareService: ShareService = DIContainer.shared.shareService
    ) {
        self.init(
            entity.id,
            networkService: networkService,
            persistentService: persistentService,
            shareService: shareService
        )
        self.movieResponse = entity
    }
    
    func activate() {
        view?.configureWishlistButton(isInWishlist)
        Task {
            if movieResponse != nil {
                await loadPartialData()
            } else {
                await loadData()
            }
        }
    }
    
    func didTapWishlistButton() {
        isInWishlist ? persistentService.removeFromWishlist(id) : persistentService.addToWishlist(id)
        view?.configureWishlistButton(isInWishlist)
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
            movieResponse = response
            updateUI()
        case .failure(let error):
            print(error)
            showError()
        }
        
        view?.hideLoading()
    }
    
    @MainActor
    private func loadPartialData() async {
        view?.showLoading()
        imagesResponse = try? await networkService.sendRequest(request: KPImagesRequest(id: id, limit: 15)).get()
        view?.hideLoading()
        updateUI()
    }
    
    private func updateUI() {
        guard let model = movieResponse else {
            return
        }
        let cast: [Model.CastMember] = (model.persons ?? []).map {
            artist in
            
            .init(
                imageURL: URL(string: artist.photo ?? ""),
                name: artist.name,
                role: artist.profession,
                didSelectHandler: {
                    [weak self] in
                    
                    self?.router?.showArtist(artist.id)
                }
            )
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
