//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import Foundation
import KPNetwork

final class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListControllerProtocol?
    var router: MovieListRouter!
    
    private let networkService: KPNetworkClient
    private var slug: [String]?
    private var genre: String?
    private var movies = [KPMovieSearchEntity.KPSearchMovie]()
    private var genres: [String] {
        ["All"] + Set(movies.compactMap { $0.genres }.flatMap { $0 }.compactMap { $0.name?.capitalized }).sorted()
    }
    private var firstLoad = true
    
    init(slug: String?, genre: String?, networkService: KPNetworkClient) {
        if let slug {
            self.slug = [slug]
        }
        self.genre = genre
        self.networkService = networkService
    }
    
    func activate() {
        Task {
            await loadData()
        }
    }
    
    
    func loadData() async {
        await MainActor.run {
            view?.showLoading()
        }
        let result = await networkService.sendRequest(
            request: KPMovieSearchRequest(
                limit: 250,
                lists: slug
            )
        )
        switch result {
        case .success(let response):
            self.movies = response.docs
            await updateUI()
        case .failure:
            await showError()
        }
        await MainActor.run {
            view?.hideLoading()
        }
    }
    
    @MainActor
    func updateUI() async {
        
        var movies = movies
        var genrePreselectedIndex = 0
        if let genre {
            movies = movies.filter { ($0.genres ?? []).compactMap { $0.name }.contains(genre) }
            genrePreselectedIndex = genres.map { $0.lowercased() }.firstIndex(of: genre) ?? 0
        }
        
        view?.update(
            with: .init(
                movies: movies.map {
                    movie in
                    
                    return .init(
                        model: .init(
                            imageURL: URL(string: movie.poster?.previewUrl ?? ""),
                            name: movie.name ?? "",
                            year: movie.year,
                            lenght: movie.movieLength,
                            genre: movie.genres?.prefix(3).compactMap { $0.name?.capitalized }.joined(separator: ", "),
                            rating: movie.rating?.kp,
                            ageRating: movie.ratingMpaa?.uppercased()
                        ),
                        didSelectHandler: {
                            [weak self] in
                            
                            self?.router.showMovie(movie.id)
                        }
                    )
                },
                genres: genres.map {
                    genre in
                    
                    return .init(
                        title: genre,
                        didSelectHandler: {
                            [weak self] in
                            
                            self?.didSelectGenre(genre)
                        }
                    )
                },
                genrePreselectedIndex: genrePreselectedIndex,
                updateGenres: firstLoad
            )
        )
        firstLoad = false
    }
    
    @MainActor
    func showError() async {
        view?.showError(
            "Не удалось получить фильмы",
            message: "Попробуйте еще раз",
            actionTitle: "Обновить",
            action: {
                [weak self] stub in
                
                stub.removeFromSuperview()
                Task {
                    await self?.loadData()
                }
            }
        )
    }
    
    @MainActor
    func didSelectGenre(_ genre: String) {
        if genre == "All" {
            self.genre = nil
        } else {
            self.genre = genre.lowercased()
        }
        Task {
            await updateUI()
        }
    }
}
