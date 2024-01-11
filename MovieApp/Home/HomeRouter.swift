//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import UIKit

final class HomeRouter: Router, HomeRouterProtocol {
    func showMovieLists() {
        pushScreen(MovieListsAssembly().build())
    }
    
    func showMovieDetail(_ id: Int) {
        pushScreen(MovieDetailAssembly(id: id).build())
    }
    
    func showMovieList(title: String, slug: String?, genre: String?) {
        pushScreen(MovieListAssembly(title: title, slug: slug, genre: genre).build())
    }
    
    func showWishlist() {
        pushScreen(WishlistAssembly().build())
    }
    
    func showProfile() {
        guard let tabBarController = controller?.tabBarController else {
            return
        }
        tabBarController.selectedIndex = (tabBarController.viewControllers?.count ?? 1) - 1
    }
    
    func showSearch() {
        guard let tabBarController = controller?.tabBarController else {
            return
        }
        guard let searchNavController = tabBarController.viewControllers?[1] as? UINavigationController,
                let searchPresenter = (searchNavController.viewControllers.first as? SearchController)?.presenter else {
            return
        }
        searchPresenter.setNeedsKeyboard()
        tabBarController.selectedIndex = 1
    }
}
