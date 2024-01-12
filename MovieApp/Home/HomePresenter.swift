//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import Foundation
import KPNetwork

private typealias ProfileModel = HomeController.Model.Profile

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    var realmService: RealmServiceProtocol?
    private let networkService: KPNetworkClient
    
    private var listsResponse: KPListSearchEntity?
    private var moviesResponse: KPMovieSearchEntity?
    private var genres: [String] {
        ["All"] + Set((moviesResponse?.docs ?? []).compactMap { $0.genres }.flatMap { $0 }.compactMap { $0.name?.capitalized }).sorted()
    }
    private var selectedGenre: String?
    
    init(networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.networkService = networkService
    }
    
    func activate() {
        view?.showLoading()
        Task {
            //            async let genresRequest = await networkService.sendRequest(request: KPPossibleValuesRequest(value: .genres))
            async let moviesRequest = await networkService.sendRequest(request: KPMovieSearchRequest(limit: 250, id: nil))
            
            async let listsRequest = await networkService.sendRequest(request: KPListSearchRequest(category: nil))
            let result = await (listsRequest, moviesRequest)
            
            await MainActor.run {
                view?.hideLoading()
            }
            
            guard let listsResult = try? result.0.get(),
                  let moviesResult = try? result.1.get() else {
                await showError()
                return
            }
            //            cacheService.genresValues = genresResult
            moviesResponse = moviesResult
            listsResponse = listsResult
            await updateUI()
        }
    }
    
    func didTapWishlistButton() {
        router?.showWishlist()
    }
    
    func didTapProfile() {
        router?.showProfile()
    }
    
    func didTapSearch() {
        router?.showSearch()
    }
    
    func fetchUser() -> User? {        
        return realmService?.fetchUser()
    }
    
    @MainActor
    private func updateUI(onlyPopular: Bool = false) {
        guard let listsResponse, let moviesResponse else {
            return
        }
        
        var movies = moviesResponse.docs
        if let selectedGenre {
            movies = movies.filter { ($0.genres ?? []).compactMap { $0.name }.contains(selectedGenre) }
        }
        
        let genrePreselectedIndex: Int = {
            guard let selectedGenre else {
                return 0
            }
            return genres.map { $0.lowercased() }.firstIndex(of: selectedGenre.lowercased()) ?? 0
        }()
        
        view?.update(
            with: .init(
                categories: .init(
                    categories: listsResponse.docs.filter { $0.category != "0" }.map {
                        movieList in
                        
                        let count: String? = {
                            guard let moviesCount = movieList.moviesCount else {
                                return nil
                            }
                            switch moviesCount {
                            case 0:
                                return nil
                            case 1:
                                return "1 movie"
                            default:
                                return "\(moviesCount) movies"
                            }
                        }()
                        
                        return .init(
                            imageURL: URL(string: movieList.cover?.url ?? ""),
                            title: movieList.name ?? "",
                            count: count,
                            didSelectHandler: {
                                [weak self] in
                                
                                self?.router?.showMovieList(
                                    title: movieList.name ?? "",
                                    slug: movieList.slug ?? "",
                                    genre: nil
                                )
                            }
                        )
                    },
                    seeAllHandler: {
                        [weak self] in
                        
                        self?.router?.showMovieLists()
                    }
                ),
                genres: .init(
                    genres:  genres.map {
                        genre in
                        
                        return .init(
                            title: genre,
                            didSelectHandler: {
                                [weak self] in
                                
                                self?.didSelectGenre(genre)
                            }
                        )
                    },
                    preselectedIndex: genrePreselectedIndex
                ),
                popularMovies: .init(
                    movies: movies.map {
                        movie in
                        
                        return .init(
                            imageURL: URL(string: movie.poster?.previewUrl ?? ""),
                            title: movie.name ?? "",
                            genre: movie.genres?.compactMap { $0.name }.joined(separator: ", "),
                            rating: movie.rating?.kp,
                            didSelect: {
                                [weak self] in
                                
                                self?.router?.showMovieDetail(movie.id)
                            }
                        )
                    },
                    seeAllHandler: {
                        [weak self] in
                        
                        self?.router?.showMovieList(
                            title: "Popular movies",
                            slug: nil,
                            genre: self?.selectedGenre
                        )
                    }
                ), 
                profile: makeProfile()
            ),
            onlyPopular: onlyPopular
        )
    }
    
    private func makeProfile() -> ProfileModel {
        .init(image: .profilePicture1, text: "Hello, Smith")
    }
    
    private func didSelectGenre(_ genre: String) {
        if genre == "All" {
            selectedGenre = nil
        } else {
            selectedGenre = genre.lowercased()
        }
        Task {
            await updateUI(onlyPopular: true)
        }
    }
    
    @MainActor
    private func showError() async {
        view?.showError(
            "Не получилось загрузить все данные",
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
