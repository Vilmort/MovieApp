//
//  SearchAssembly.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

final class SearchAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = SearchController()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        controller.presenter = presenter
        presenter.router = router
        presenter.view = controller
        router.controller = controller
        
        return controller
    }
}
