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
    init(view: OnboardingViewProtocol)
    func safeUserDefaults()
    func createSlides() -> [OnboardingView]
    func ifSkipButtonHidden(id: Int) -> Bool
    func firstTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func secondTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func thirdTransform (when percentHorizontalOffset: CGFloat) -> CGAffineTransform
    func forthTransform(when percentHorizontalOffset: CGFloat) -> CGAffineTransform
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    var onboardingModels: [OnboardingModel] = [
        OnboardingModel(title: "Исследуйте Разнообразие Жанров", description: "Погрузитесь в разнообразие кинематографа — от захватывающих боевиков до трогательных драм. MovieApp предлагает широкий выбор жанров, чтобы каждый нашел что-то по своему вкусу.", image: .onboarding1),
        OnboardingModel(title: "Персонализированные Рекомендации", description: "На основе ваших предпочтений MovieApp создает персонализированные рекомендации. Позвольте нам угадать, что вас заинтересует, и порадуйтесь новым кинематографическим открытиям.", image: .onboarding2),
        OnboardingModel(title: "Будьте В Центре Кинособытий", description: "Следите за новостями, трейлерами и обзорами. MovieApp делится с вами всеми актуальными кинособытиями, чтобы вы всегда были в курсе.", image: .onboarding3)
    ]
    
    weak var view: OnboardingViewProtocol!
    
    required init(view: OnboardingViewProtocol) {
        self.view = view
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
}
