//
//  HomeCategoryView.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

final class HomeCategoryView: CustomView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let nameBlur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let infoLabel = UILabel()
    private let infoBlur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func configure() {
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubviews(imageView, nameBlur, infoBlur, nameLabel, infoLabel)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        nameBlur.snp.makeConstraints {
            $0.edges.equalTo(nameLabel).inset(-4)
        }
        nameBlur.layer.cornerRadius = 8
        infoBlur.layer.masksToBounds = true
        
        infoLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        infoBlur.snp.makeConstraints {
            $0.edges.equalTo(infoLabel).inset(-4)
        }
        infoBlur.layer.cornerRadius = 8
        infoBlur.layer.masksToBounds = true
    }
}

extension HomeCategoryView: Configurable {
    struct Model {
        let imageURL: URL?
        let title: String
        let info: String?
    }
    
    func update(with model: Model?) {
        guard let model else {
            imageView.update(with: nil)
            return
        }
        imageView.update(
            with: .init(
                image: nil,
                url: model.imageURL,
                tintColor: nil,
                contenMode: .scaleAspectFill
            )
        )
        nameLabel.update(
            with: .init(
                text: model.title,
                font: .montserratRegular(ofSize: 16),
                textColor: .white,
                numberOfLines: 2
            )
        )
        
        infoLabel.isHidden = model.info == nil
        infoBlur.isHidden = infoLabel.isHidden
        if let info = model.info {
            infoLabel.update(
                with: .init(
                    text: info,
                    font: .montserratMedium(ofSize: 12),
                    textColor: .white,
                    numberOfLines: 1
                )
            )
        }
    }
}
