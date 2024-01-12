//
//  MovieListsAssembly.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit

final class MovieListsAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let router = MovieListsRouter()
        let presenter = MovieListsPresenter(networkService: DIContainer.shared.networkService)
        let controller = MovieListsController()
        
        presenter.router = router
        presenter.view = controller
        router.controller = controller
        controller.presenter = presenter
        
        controller.hidesBottomBarWhenPushed = true
        
        return controller
    }
}
