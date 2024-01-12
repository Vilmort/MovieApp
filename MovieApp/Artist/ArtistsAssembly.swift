//
//  ArtistsAssembly.swift
//  MovieApp
//
//  Created by Victor on 12.01.2024.
//

import UIKit

final class ArtistsAssembly: ModuleAssembly {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func build() -> UIViewController {
        let controller = ArtistController()
        let presenter = ArtistPresenter(id: id)
        let router = ArtistRouter()
        
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        
        return controller
    }
}
