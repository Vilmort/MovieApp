//
//  ViewController.swift
//  Movie
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit

final class TabBarController: UITabBarController, TabBarViewProtocol {
    
    //MARK: - Properties
    var presenter: TabBarPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        createTabBar()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 90
////        tabBar.itemPositioning = .automatic
//        
//    }
    
    //MARK: - GenerateVC
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = UINavigationController(rootViewController: viewController)
  return vc
    }
    
    
    //MARK: - SetupTabBar
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .appDark
        appearance.selectionIndicatorTintColor = .appBlue
        appearance.compactInlineLayoutAppearance.normal.iconColor = .appTextLineDark
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = appearance.selectionIndicatorTintColor
    }
    
    
    //MARK: - CreateTabBar
    private func createTabBar() {
        let homeVC = Builder.createHome()
        let searchVC = Builder.createSearch()
        let treeVC = Builder.createTree()
        let profileVC = Builder.createProfile()
        
        viewControllers = [
            generateVC(homeVC, "Home", .home),
            generateVC(searchVC, "Search", .search),
            generateVC(treeVC, "Tree", .puzzle),
            generateVC(profileVC, "Profile", .profile)
        ]
    }
}

