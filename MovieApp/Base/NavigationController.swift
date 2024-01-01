//
//  NavigationController.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratMedium(ofSize: 16)
        ]
        
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.standardAppearance = appearance
    }
}
