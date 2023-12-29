//
//  MovieDetailAssembly.swift
//  MovieApp
//
//  Created by Victor Rubenko on 30.12.2023.
//

import UIKit

final class MovieDetailAssembly: ModuleAssembly {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func build() -> UIViewController {
        let presenter = MovieDetailPresenter(id)
        let controller = MovieDetailController()
        let router = MovieDetailRouter()
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        
        return controller
    }
}
