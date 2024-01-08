//
//  OnboardingRouter.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation
protocol OnboardingRouterProtocol {
    func showTabBarVc()
}

final class OnboardingRouter: Router, OnboardingRouterProtocol {
    func showTabBarVc() {
        pushScreen(Builder.createTabBar())
    }
}
