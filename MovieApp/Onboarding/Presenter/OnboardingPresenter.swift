//
//  OnboardingPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 27.12.2023.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {}


protocol OnboardingPresenterProtocol: AnyObject {
    var onboardingModels: [OnboardingModel] { get }
    init(view: OnboardingViewProtocol, router: OnboardingRouterProtocol)
    func safeUserDefaults()
    func createSlides() -> [OnboardingView]
    func goToHomeScreen()
    func ifSkipButtonHidden(id: Int) -> Bool
    func firstTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func secondTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func thirdTransform (when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func forthTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    var onboardingModels: [OnboardingModel] = [
        OnboardingModel(title: "Explore a Variety of Genres".localized,
                        description: "Immerse yourself in a variety of cinema - from thrilling action films to heartwarming dramas. MovieApp offers a wide selection of genres to ensure there's something for everyone".localized, 
                        image: .onboarding1),
        OnboardingModel(title: "Personalized Recommendations".localized,
                        description: "Based on your preferences, MovieApp creates personalized recommendations. Let us guess what will interest you and enjoy new cinematic discoveries.".localized,
                        image: .onboarding2),
        OnboardingModel(title: "Be at the Center of Cinema Events".localized,
                        description: "Stay tuned for news, trailers and reviews. MovieApp shares with you all the latest film events so that you are always up to date.".localized,
                        image: .onboarding3)
    ]
    
    weak var view: OnboardingViewProtocol!
    private var router: OnboardingRouterProtocol?
    required init(view: OnboardingViewProtocol, router: OnboardingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func safeUserDefaults() {
        UDService.onboardingCompleted()
    }
    
    func createSlides() -> [OnboardingView] {
        var onboardingView: [OnboardingView] = []
        for model in onboardingModels {
            let view = createSlide(model: model)
            onboardingView.append(view)
        }
        return onboardingView
    }
    
    private func createSlide(model: OnboardingModel) -> OnboardingView {
        let slide = OnboardingView()
        slide.configureOnboarding(title: model.title, description: model.description, image: model.image)
        return slide
    }
    
    func ifSkipButtonHidden(id: Int) -> Bool {
        id == onboardingModels.count - 1 ? true : false
    }
    
    func firstTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform {
        let transform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                          y: (0.5 - percentHorizontalOffset) / 0.5)
        return transform
    }
    func secondTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform {
        let transform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                          y: percentHorizontalOffset / 0.5)
        return transform
    }
    
    func thirdTransform (when percentHorizontalOffset: CGFloat) -> CGAffineTransform {
        let transform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                          y: (1 - percentHorizontalOffset) / 0.5)
        return transform
    }
    
    func forthTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform {
        let transform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                               y: percentHorizontalOffset)
        return transform
    }
    
    func goToHomeScreen() {
        router?.showTabBarVc()
    }
    
    
}
