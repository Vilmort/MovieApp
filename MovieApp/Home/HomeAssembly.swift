//
//  HomeAssembly.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import UIKit

final class HomeAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = HomeController()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        
        return controller
    }
}
