//
//  MovieListAssembly.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class MovieListAssembly: ModuleAssembly {
    
    private let title: String
    private let slug: String?
    private let genre: String?
    
    init(title: String, slug: String?, genre: String?) {
        self.title = title
        self.slug = slug
        self.genre = genre
    }
    
    func build() -> UIViewController {
        let router = MovieListRouter()
        let presenter = MovieListPresenter(
            slug: slug,
            genre: genre,
            networkService: DIContainer.shared.networkService
        )
        let controller = MovieListController()
        controller.title = title
        
        presenter.router = router
        presenter.view = controller
        router.controller = controller
        controller.presenter = presenter
        
        return controller
    }
}
