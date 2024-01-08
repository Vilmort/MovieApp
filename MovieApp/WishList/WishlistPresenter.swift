//
//  WishlistPresenter.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import Foundation
import KPNetwork

final class WishlistPresenter: WishlistPresenterProtocol {
    
    weak var view: WishlistControllerProtocol?
    var router: WishlistRouterProtocol?
    
    private let networkService: KPNetworkClient
    private let persistentService: PersistentServiceProtocol
    
    init(
        networkService: KPNetworkClient = DIContainer.shared.networkService,
        persistentService: PersistentServiceProtocol = DIContainer.shared.persistentService
    ) {
        self.networkService = networkService
        self.persistentService = persistentService
    }
    
    func activate() {
        let wishlist = persistentService.getWishlist()
        guard !wishlist.isEmpty else {
            view?.update(with: .init(items: []))
            return
        }
        view?.showLoading()
        Task {
            let result = await networkService.sendRequest(request: KPMovieSearchRequest(id: wishlist.compactMap { String($0.id) }))
            switch result {
            case let .success(response):
                await updateUI(response)
            case .failure:
                await showError()
            }
        }
    }
    
    @MainActor
    private func updateUI(_ response: KPMovieSearchEntity) {
        view?.update(
            with: .init(items: response.docs.map {
                movie in
                
                .init(
                    imageURL: URL(string: movie.poster?.previewUrl ?? ""),
                    name: movie.name ?? "",
                    genre: movie.genres?.compactMap { $0.name?.capitalized }.joined(separator: ", "),
                    movieType: movie.type?.rawValue ?? "",
                    rating: movie.rating?.kp,
                    wishlistHandler: {
                        [weak self] in
                        
                        self?.removeFromWishlist(movie.id)
                    },
                    didSelectHandler: {
                        [weak self] in
                        
                        self?.router?.showMovie(movie.id)
                    }
                )
            })
        )
        view?.hideLoading()
    }
    
    @MainActor
    private func showError() async {
        view?.showError(
            "Не удалось загрузить список",
            message: nil,
            actionTitle: "Обновить",
            action: {
                [weak self] stub in
                
                stub.removeFromSuperview()
                self?.activate()
            }
        )
    }
    
    private func removeFromWishlist(_ id: Int) {
        guard let index = persistentService.getWishlist().firstIndex(where: { $0.id == id }) else {
            return
        }
        persistentService.removeFromWishlist(id)
        view?.removeFromWishlist(index)
    }
}
