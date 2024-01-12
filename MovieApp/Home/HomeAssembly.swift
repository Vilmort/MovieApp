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
        let realmService = RealmService()
        let presenter = HomePresenter()
        let router = HomeRouter()
        controller.presenter = presenter
        presenter.realmService = realmService
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        return controller
    }
}
