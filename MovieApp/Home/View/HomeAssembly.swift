//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 09.01.2024.
//

import UIKit


final class HomeAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let presenter = HomePresenterMy(networkService: DIContainer.shared.networkService)
        let controller = HomeViewControllerMy(homeView: HomeCollectionView(), presenter: presenter)
        presenter.view = controller
        controller.presenter = presenter
        return controller
    }
}
