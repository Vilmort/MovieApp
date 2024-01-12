//
//  OnboardingRouter.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit

protocol OnboardingRouterProtocol {
    func showTabBarVc()
}

final class OnboardingRouter: Router, OnboardingRouterProtocol {
    func showTabBarVc() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowDelegate = windowScene.delegate as? SceneDelegate {
            let vc = Builder.createTabBar()
            vc.tabBarController?.selectedIndex = 3
            let window = windowDelegate.window
            window?.rootViewController = vc
        }
    }
}
