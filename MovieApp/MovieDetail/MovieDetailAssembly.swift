//
//  MovieDetailAssembly.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit
import KPNetwork

final class MovieDetailAssembly: ModuleAssembly {
    let id: Int
    let entity: KPMovieEntity?
    
    init(id: Int) {
        self.id = id
        self.entity = nil
    }
    
    init(entity: KPMovieEntity) {
        self.entity = entity
        self.id = entity.id
    }
    
    func build() -> UIViewController {
        let presenter: MovieDetailPresenter
        if let entity {
            presenter = MovieDetailPresenter(entity: entity)
        } else {
            presenter = MovieDetailPresenter(id)
        }
        let controller = MovieDetailController()
        let router = MovieDetailRouter()
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        
        return controller
    }
}
