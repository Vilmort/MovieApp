//
//  MovieActionsView.swift
//  MovieApp
//
//  Created by Victor on 02.01.2024.
//

import UIKit

final class MovieActionsView: CustomView {
    private let watchButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let vStack = UIStackView()
    private let hStack = UIStackView()
    
    private var watchClosure: (() -> Void)?
    private var shareClosure: (() -> Void)?
    
    override func configure() {
        addSubview(vStack)
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vStack.addArrangedSubview(hStack)
        hStack.addArrangedSubviews(watchButton, shareButton)
        hStack.spacing = 50
        hStack.alignment = .center
        
        var watchConfig = UIButton.Configuration.filled()
        watchConfig.title = "Watch".localized
        watchConfig.image = .play
        watchConfig.baseBackgroundColor = .appOrange
        watchConfig.baseForegroundColor = .white
        watchConfig.imagePlacement = .leading
        watchConfig.titlePadding = 8
        watchConfig.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        watchButton.configuration = watchConfig
        watchButton.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        
        var shareConfig = UIButton.Configuration.filled()
        shareConfig.image = .share.withRenderingMode(.alwaysTemplate)
        shareConfig.baseBackgroundColor = .appSoft
        shareConfig.baseForegroundColor = .appBlue
        shareConfig.imagePlacement = .all
        shareConfig.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
        shareConfig.cornerStyle = .capsule
        
        shareButton.configuration = shareConfig
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    @objc
    private func didTapWatch() {
        watchClosure?()
    }
    
    @objc
    private func didTapShare() {
        shareClosure?()
    }
}

extension MovieActionsView: Configurable {
    struct Model {
        let watchClosure: (() -> Void)?
        let shareClosure: (() -> Void)?
    }
    
    func update(with model: Model?) {
        watchClosure = model?.watchClosure
        shareClosure = model?.shareClosure
    }
}
