//
//  MovieRatingSmallView.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class MovieRatingSmallView: CustomView {
    private let imageLabel = ImageTitleSubtitleView()
    private let blurView = {
        let effect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: effect)
        return blurView
    }()
    
    override func configure() {
        addSubviews(blurView, imageLabel)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(4)
        }
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

extension MovieRatingSmallView: Configurable {
    struct Model {
        let rating: Double
    }
    
    func update(with model: Model?) {
        guard let model else {
            imageLabel.update(with: nil)
            return
        }
        imageLabel.update(
            with: .init(
                image: .init(
                    image: .star,
                    tintColor: .appOrange,
                    size: .init(width: 16, height: 16)
                ),
                title: .init(
                    text: "\(Double(Int(model.rating * 10)) / 10)",
                    font: .montserratMedium(ofSize: 12),
                    textColor: .appOrange,
                    numberOfLines: 1
                ),
                spacing: 4
            )
        )
    }
}
