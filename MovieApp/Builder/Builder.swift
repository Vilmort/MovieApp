//
//  Builder.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit

final class Builder {
    
//    TabBarVC
    static func createTabBar() -> UIViewController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
// Home
    static func createHome() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    // Search
    static func createSearch() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    // Tree
    static func createTree() -> UIViewController {
        let view = TreeViewController()
        let presenter = TreePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    // Profile
    static func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
