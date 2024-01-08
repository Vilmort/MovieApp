//
//  SuggestionView.swift
//  MovieApp
//
//  Created by Victor on 08.01.2024.
//

import UIKit
import Lottie

final class SuggestionView: CustomView {
    private let titleLabel = UILabel()
    private let container = UIView()
    private let suggestion = ImageTitleSubtitleView()
    private let animationView = LottieAnimationView(animation: .named("suggestion"))
    private let openButton = UIButton(type: .system)
    private var didTapOpenClosure: (() -> Void)?
    
    override func configure() {
        addSubviews(animationView, titleLabel, container, openButton)
        
        animationView.contentMode = .scaleAspectFill
        animationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.top.equalToSuperview().offset(110)
        }
        
        container.layer.cornerRadius = 16
        container.backgroundColor = .appSoft.withAlphaComponent(0.85)
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(100)
        }
        
        container.addSubview(suggestion)
        suggestion.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        var openConfig = UIButton.Configuration.filled()
        openConfig.title = "Открыть"
        openConfig.image = .play
        openConfig.baseBackgroundColor = .appOrange
        openConfig.baseForegroundColor = .white
        openConfig.imagePlacement = .leading
        openConfig.titlePadding = 8
        openConfig.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        openButton.configuration = openConfig
        openButton.addTarget(self, action: #selector(didTapOpen), for: .touchUpInside)
        
        openButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(container.snp.bottom).offset(16)
        }
    }
    
    func playAnimation() {
        animationView.play()
    }
    
    @objc
    private func didTapOpen() {
        didTapOpenClosure?()
    }
}

extension SuggestionView: Configurable {
    struct Model {
        let title: UILabel.Model
        let suggestion: ImageTitleSubtitleView.Model
        let openClosure: (() -> Void)
    }
    
    func update(with model: Model?) {
        titleLabel.update(with: model?.title)
        suggestion.update(with: model?.suggestion)
        didTapOpenClosure = model?.openClosure
    }
}
