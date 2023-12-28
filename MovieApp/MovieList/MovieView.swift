//
//  MovieView.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class MovieView: CustomView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let yearImageLabel = ImageLabelView()
    private let lenghtImageLabel = ImageLabelView()
    private let genreImageLabel = ImageLabelView()
    private let ratingView = MovieRatingSmallView()
    private let infoStack = UIStackView()
    private let ageView = MovieAgeView()
    
    override func configure() {
        addSubviews(imageView, ratingView, infoStack, ageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 112, height: 147))
            $0.leading.top.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints {
            $0.leading.top.equalTo(imageView).inset(8)
        }
        
        infoStack.addArrangedSubviews(nameLabel, yearImageLabel, lenghtImageLabel, genreImageLabel)
        infoStack.spacing = 10
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        ageView.snp.makeConstraints {
            $0.centerY.equalTo(lenghtImageLabel)
            $0.leading.equalTo(lenghtImageLabel.snp.trailing).offset(12)
        }
    }
}

extension MovieView: Configurable {
    struct Model {
        let imageURL: URL?
        let name: String
        let year: Int?
        let lenght: Int?
        let genre: String?
        let rating: Double?
        let ageRating: Int?
    }
    
    func update(with model: Model?) {
        guard let model else {
            imageView.update(with: nil)
            nameLabel.update(with: nil)
            yearImageLabel.update(with: nil)
            lenghtImageLabel.update(with: nil)
            genreImageLabel.update(with: nil)
            ratingView.update(with: nil)
            ageView.update(with: nil)
            return
        }
        imageView.kf.setImage(with: model.imageURL)
        nameLabel.update(
            with: .init(
                text: model.name,
                font: .montserratMedium(ofSize: 16),
                textColor: .white,
                numberOfLines: 1
            )
        )
        
        yearImageLabel.isHidden = model.year == nil
        if let year = model.year {
            yearImageLabel.update(
                with: .init(
                    text: .init(
                        text: "\(year)",
                        font: .montserratMedium(ofSize: 14),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(
                        image: .calendar,
                        tintColor: .appTextGrey,
                        size: .init(width: 16, height: 16)
                    ),
                    spacing: 4
                )
            )
        }
        
        lenghtImageLabel.isHidden = model.lenght == nil
        if let lenght = model.lenght {
            lenghtImageLabel.update(
                with: .init(
                    text: .init(
                        text: "\(lenght) minutes",
                        font: .montserratMedium(ofSize: 14),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(
                        image: .clock,
                        tintColor: .appTextGrey,
                        size: .init(width: 16, height: 16)
                    ),
                    spacing: 4
                )
            )
        }
        
        genreImageLabel.isHidden = model.genre == nil
        if let genre = model.genre {
            genreImageLabel.update(
                with: .init(
                    text: .init(
                        text: "\(genre)".capitalized,
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(
                        image: .film,
                        tintColor: .appTextGrey,
                        size: .init(width: 16, height: 16)
                    ),
                    spacing: 4
                )
            )
        }
        
        ratingView.isHidden = model.rating == nil
        ratingView.update(with: .init(rating: model.rating ?? 0))
        
        ageView.isHidden = model.ageRating == nil
        ageView.update(with: .init(text: "\(model.ageRating ?? 0)+", color: .appBlue))
    }
}
