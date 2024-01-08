//
//  SuggestionsAssembly.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import UIKit

final class SuggestionsAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = SuggestionsController()
        let presenter = SuggestionsPresenter()
        let router = SuggestionsRouter()
        
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        
        return controller
    }
}
