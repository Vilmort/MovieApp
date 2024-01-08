//
//  WishlistMovieView.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import UIKit

final class WishlistMovieView: CustomView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    private let typeLabel = UILabel()
    private let ratingView = MovieRatingSmallView()
    private let wishlistButton = UIButton(type: .system)
    
    private var wishlistHandler: (() -> Void)?
    
    override func configure() {
        
        backgroundColor = .appSoft
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubviews(imageView, titleLabel, genreLabel, typeLabel, ratingView, wishlistButton)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 123, height: 81))
            $0.leading.top.bottom.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        genreLabel.snp.makeConstraints  {
            $0.top.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        typeLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.centerY.equalTo(wishlistButton)
        }
        typeLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        ratingView.snp.makeConstraints {
            $0.centerY.equalTo(wishlistButton)
            $0.leading.equalTo(typeLabel.snp.trailing).offset(4)
        }
        
        wishlistButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalTo(imageView)
            $0.size.equalTo(CGSize(width: 32, height: 32))
        }
        wishlistButton.setImage(.heart.withRenderingMode(.alwaysTemplate), for: .normal)
        wishlistButton.tintColor = .red
        wishlistButton.addTarget(self, action: #selector(didTapWishlistButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapWishlistButton() {
        wishlistHandler?()
    }
}

extension WishlistMovieView: Configurable {
    struct Model {
        let imageURL: URL?
        let name: String
        let genre: String?
        let movieType: String?
        let rating: Double?
        let wishlistHandler: (() -> Void)
    }
    
    func update(with model: Model?) {
        guard let model else {
            imageView.update(with: nil)
            return
        }
        imageView.kf.setImage(with: model.imageURL)
        titleLabel.update(
            with: .init(
                text: model.name,
                font: .montserratSemiBold(ofSize: 14),
                textColor: .white,
                numberOfLines: 2
            )
        )
        genreLabel.update(
            with: .init(
                text: (model.genre ?? "").capitalized,
                font: .montserratMedium(ofSize: 12),
                textColor: .white,
                numberOfLines: 1
            )
        )
        typeLabel.update(
            with: .init(
                text: model.movieType ?? "",
                font: .montserratMedium(ofSize: 12),
                textColor: .appTextGrey,
                numberOfLines: 1
            )
        )
        
        ratingView.isHidden = model.rating == nil
        ratingView.update(with: .init(rating: model.rating ?? 0, withBlur: false))
        
        wishlistHandler = model.wishlistHandler
    }
}
