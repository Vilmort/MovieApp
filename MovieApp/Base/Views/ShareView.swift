//
//  ShareView.swift
//  MovieApp
//
//  Created by Victor on 03.01.2024.
//

import UIKit

final class ShareView: CustomView {
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let stack = UIStackView()
    private let container = UIView()
    private let label = UILabel()
    private let button = UIButton()
    private var model: Model?
    
    override func configure() {
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(container)
        container.backgroundColor = .appSoft
        container.layer.cornerRadius = 16
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        container.addSubview(button)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .appDark
        config.baseForegroundColor = .appTextGrey
        config.image = .close1.withRenderingMode(.alwaysTemplate)
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.cornerStyle = .large
        button.configuration = config
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(15)
        }
        
        container.addSubview(label)
        label.update(
            with: .init(
                text: "Share to",
                font: .montserratSemiBold(ofSize: 18),
                textColor: .white,
                numberOfLines: 0,
                alignment: .center
            )
        )
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(64)
        }
        
        container.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-51)
        }
        stack.spacing = 16
    }
    
    func animate() {
        alpha = 0
        UIView.animate(withDuration: 0.5, animations: { self.alpha = 1 })
    }
    
    @objc
    private func didTapClose() {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                [weak self] in
                
                self?.alpha = 0
            },
            completion: {
                [weak self] _ in
                
                self?.removeFromSuperview()
                self?.model?.onClose?()
            }
        )
    }
    
    @objc
    private func didTapShare(_ sender: UIButton) {
        model?.share[sender.tag].action()
    }
}

extension ShareView: Configurable {
    struct Model {
        struct Share {
            let image: UIImage
            let action: () -> Void
        }
        
        let share: [Share]
        let onClose: (() -> Void)?
    }
    
    func update(with model: Model?) {
        guard let model else {
            return
        }
        
        self.model = model
        
        stack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        model.share.enumerated().forEach {
            let button = UIButton(type: .system)
            button.setImage($0.element.image, for: .normal)
            button.tintColor = .white
            button.imageView?.contentMode = .scaleAspectFill
            button.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 49, height: 49))
            }
            button.tag = $0.offset
            button.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        
    }
}
