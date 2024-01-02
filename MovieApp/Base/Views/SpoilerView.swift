//
//  SpoilerView.swift
//  MovieApp
//
//  Created by Victor on 01.01.2024.
//

import UIKit

final class SpoilerView: CustomView {
    private let button = UIButton()
    private let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func configure() {
        var config = UIButton.Configuration.plain()
        config.title = "👁 Показать"
        config.baseForegroundColor = .appBlue
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        button.configuration = config
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        addSubview(effectView)
        effectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc
    private func didTapButton() {
        self.removeFromSuperview()
    }
}
