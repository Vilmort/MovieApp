//
//  MovieAgeView.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class MovieAgeView: CustomView {
    private let label = UILabel()
    
    override func configure() {
        addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(7)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        layer.borderColor = UIColor.appBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 3
    }
}

extension MovieAgeView: Configurable {
    struct Model {
        let text: String
        let color: UIColor
    }
    
    func update(with model: Model?) {
        guard let model else {
            label.text = nil
            return
        }
        label.update(
            with: .init(
                text: model.text,
                font: .montserratMedium(ofSize: 12),
                textColor: model.color,
                numberOfLines: 1
            )
        )
        layer.borderColor = model.color.cgColor
    }
}
