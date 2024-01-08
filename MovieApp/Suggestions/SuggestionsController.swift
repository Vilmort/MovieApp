//
//  SuggestionsController.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import UIKit
import Lottie

final class SuggestionsController: ViewController, SuggestionsViewProtocol {
    
    var presenter: SuggestionsPresenterProtocol!
    
    private let suggestionView = SuggestionView()
    private let animationView = LottieAnimationView(animation: .named("tree"))
    private var animationLooped = false
    private var buttons = [UIButton]()
    private let positions: [(x: Double, y: Double)] = [
        (x: 0, y: 0.18),
        (x: 0.05, y: 0.32),
        (x: 0.1, y: 0.45),
        (x: 0.14, y: 0.6)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter.activate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !animationLooped else {
            buttons.forEach {
                $0.layer.removeAllAnimations()
            }
            reloadButtonsAnimation()
            return
        }
        animationLooped = true
        animationView.play(completion: {
            [weak self] _ in
            
            self?.animationView.animationSpeed = 1
            self?.animationView.play(fromFrame: 400, toFrame: 450, loopMode: .loop)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.generateBalls()
        }
    }
    
    func update(with model: Model) {
        
    }
    
    func showSuggestion(with model: SuggestionModel) {
        configureCloseSuggestionButton(true)
        suggestionView.update(
            with: .init(
                title: .init(
                    text: "Your today recommend is...",
                    font: .montserratSemiBold(ofSize: 28),
                    textColor: .white,
                    numberOfLines: 0
                ),
                suggestion: .init(
                    image: .init(
                        image: nil,
                        url: model.imageURL,
                        tintColor: nil,
                        size: .init(width: 100, height: 150),
                        cornerRadius: 8
                    ),
                    title: .init(
                        text: model.title,
                        font: .montserratMedium(ofSize: 16),
                        textColor: .white,
                        numberOfLines: 3,
                        alignment: .center
                    ),
                    subtitle: .init(
                        text: model.subtitle ?? "",
                        font: .montserratRegular(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1,
                        alignment: .center
                    ),
                    spacing: 4
                ), 
                openClosure: model.openSuggestion
            )
        )
        view.addSubview(suggestionView)
        suggestionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        suggestionView.backgroundColor = view.backgroundColor
        suggestionView.alpha = 0
        suggestionView.playAnimation()
        UIView.animate(
            withDuration: 1,
            animations: {
                self.suggestionView.alpha = 1
            }
        )
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubview(animationView)
        animationView.animationSpeed = 1.35
        animationView.contentMode = .scaleAspectFit
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(animationView.snp.width)
        }
    }
    
    private func generateBalls() {
        var startSign: Double = -1
        for position in positions {
            let button = UIButton(type: .system)
            button.setImage(.ticket.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(didTapSuggestion), for: .touchUpInside)
            animationView.addSubview(button)
            
            let size = animationView.bounds.width / 9
            let y = position.y * animationView.bounds.height
            let x = startSign * position.x * animationView.bounds.width + animationView.center.x - size / 2
            button.frame = CGRect(x: x, y: y, width: size, height: size)
            
            buttons.append(button)
            
            button.alpha = 0
            UIView.animate(withDuration: 1) {
                button.alpha = 1
            }
            reloadButtonsAnimation()
            startSign *= -1
        }
    }
    
    private func reloadButtonsAnimation() {
        buttons.enumerated().forEach {
            (index, button) in
            
            UIView.animate(
                withDuration: 1 - Double.random(in: 0...3) / 10,
                delay: .zero,
                options: [.allowUserInteraction, .repeat, .autoreverse],
                animations: {
                    [weak button] in
                    
                    button?.transform = CGAffineTransformMakeRotation(60.0 * .pi/180)
                    button?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                }
            )
        }
    }
    
    private func configureCloseSuggestionButton(_ show: Bool) {
        guard show else {
            navigationItem.rightBarButtonItem = nil
            return
        }
        let button = UIBarButtonItem(image: .close1, style: .plain, target: self, action: #selector(didTapCloseSuggestion))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc
    private func didTapSuggestion() {
        presenter.didTapSuggestion()
    }
    
    @objc
    private func didTapCloseSuggestion() {
        configureCloseSuggestionButton(false)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.suggestionView.alpha = 0
            },
            completion: {
                _ in
                
                self.suggestionView.removeFromSuperview()
            }
        )
    }
}

extension SuggestionsController {
    struct Model {
        
    }
    
    struct SuggestionModel {
        let imageURL: URL?
        let title: String
        let subtitle: String?
        let openSuggestion: (() -> Void)
    }
}
