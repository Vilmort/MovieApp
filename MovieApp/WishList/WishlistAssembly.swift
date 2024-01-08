//
//  WishlistAssembly.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import UIKit

final class WishlistAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = WishlistController()
        let presenter = WishlistPresenter()
        let router = WishlistRouter()
        
        presenter.view = controller
        presenter.router = router
        controller.presenter = presenter
        router.controller = controller
        
        controller.hidesBottomBarWhenPushed = true
        
        return controller
    }
}
