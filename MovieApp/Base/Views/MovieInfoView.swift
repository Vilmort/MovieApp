//
//  MovieInfoView.swift
//  MovieApp
//
//  Created by Victor Rubenko on 30.12.2023.
//

import UIKit

final class MovieInfoView: CustomView {
    private let yearImageLabel = ImageLabelView()
    private let lengthImageLabel = ImageLabelView()
    private let genreImageLabel = ImageLabelView()
    private lazy var divider1 = makeDivider()
    private lazy var divider2 = makeDivider()
    private let hStack = UIStackView()
    private let ratingView = MovieRatingSmallView()
    
    override func configure() {
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        hStack.addArrangedSubviews(
            yearImageLabel,
            divider1,
            lengthImageLabel,
            divider2,
            genreImageLabel
        )
        
        addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.top.equalTo(hStack.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func makeDivider() -> UILabel {
        let label = UILabel()
        label.update(
            with: .init(
                text: "|",
                font: .montserratRegular(ofSize: 20),
                textColor: .appTextGrey,
                numberOfLines: 1,
                alignment: .center
            )
        )
        label.snp.makeConstraints {
            $0.width.equalTo(25)
        }
        return label
    }
}

extension MovieInfoView: Configurable {
    struct Model {
        let year: Int?
        let lenght: Int?
        let genre: String?
        let rating: Double
    }
    
    func update(with model: Model?) {
        
        guard let model else {
            return
        }
        
        yearImageLabel.isHidden = model.year == nil
        if let year = model.year {
            yearImageLabel.update(
                with: .init(
                    text: .init(
                        text: String(year),
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(image: .calendar, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    spacing: 4
                )
            )
        }
        
        divider1.isHidden = yearImageLabel.isHidden
        lengthImageLabel.isHidden = model.lenght == nil
        if let length = model.lenght {
            lengthImageLabel.update(
                with: .init(
                    text: .init(
                        text: "\(length) минут",
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(image: .clock, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    spacing: 4
                )
            )
        }
        
        divider2.isHidden = lengthImageLabel.isHidden
        genreImageLabel.isHidden = model.genre == nil
        if let genre = model.genre {
            genreImageLabel.update(
                with: .init(
                    text: .init(
                        text: genre,
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    image: .init(image: .film, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    spacing: 4
                )
            )
        }
        
        ratingView.update(with: .init(rating: model.rating))
    }
}
