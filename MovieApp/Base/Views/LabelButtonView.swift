//
//  LabelButtonView.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import UIKit

final class LabelButtonView: CustomView {
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private var didTapButtonHandler: (() -> Void)?
    
    override func configure() {
        addSubviews(label, button)
        
        label.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(button.snp.leading).offset(-16)
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.trailing.equalToSuperview()
        }
        button.tintColor = .appBlue
        button.titleLabel?.font = .montserratMedium(ofSize: 14)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapButton() {
        didTapButtonHandler?()
    }
}

extension LabelButtonView: Configurable {
    struct Model {
        let text: UILabel.Model
        let buttonTitle: String
        let buttonHandler: (() -> Void)?
    }
    
    func update(with model: Model?) {
        guard let model else {
            return
        }
        label.update(with: model.text)
        button.setTitle(model.buttonTitle, for: .normal)
        didTapButtonHandler = model.buttonHandler
        button.isHidden = model.buttonHandler == nil
    }
}


