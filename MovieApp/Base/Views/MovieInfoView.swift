//
//  MovieInfoView.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit

final class MovieInfoView: CustomView {
    private let yearImageLabel = ImageTitleSubtitleView()
    private let lengthImageLabel = ImageTitleSubtitleView()
    private let genreImageLabel = ImageTitleSubtitleView()
    private let countryLabel = UILabel()
    private lazy var divider1 = makeDivider()
    private lazy var divider2 = makeDivider()
    private let vStack = UIStackView()
    private let ratingView = MovieRatingSmallView()
    private let ageView = MovieAgeView()
    
    override func configure() {
        
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 4
        addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        let textHStack = UIStackView()
        vStack.addArrangedSubview(textHStack)
        
        
        textHStack.addArrangedSubviews(
            countryLabel,
            divider1,
            yearImageLabel,
            divider2,
            lengthImageLabel
        )
        
        vStack.addArrangedSubview(genreImageLabel)
        
        let infoHStack = UIStackView()
        vStack.addArrangedSubview(infoHStack)
        infoHStack.addArrangedSubviews(ratingView, ageView)
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
        let country: String?
        let year: Int?
        let lenght: Int?
        let genre: String?
        let rating: Double?
        let age: String?
    }
    
    func update(with model: Model?) {
        
        guard let model else {
            return
        }
        
        countryLabel.isHidden = model.country == nil
        countryLabel.update(
            with: .init(
                text: model.country ?? "",
                font: .montserratMedium(ofSize: 12),
                textColor: .appTextGrey,
                numberOfLines: 1
            )
        )
        
        divider1.isHidden = countryLabel.isHidden
        yearImageLabel.isHidden = model.year == nil
        if let year = model.year {
            yearImageLabel.update(
                with: .init(
                    image: .init(image: .calendar, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    title: .init(
                        text: String(year),
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    spacing: 4
                )
            )
        }
        
        divider2.isHidden = yearImageLabel.isHidden
        lengthImageLabel.isHidden = model.lenght == nil
        if let length = model.lenght {
            lengthImageLabel.update(
                with: .init(
                    image: .init(image: .clock, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    title: .init(
                        text: "\(length) мин.",
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 1
                    ),
                    spacing: 4
                )
            )
        }
        
        genreImageLabel.isHidden = model.genre == nil
        if let genre = model.genre {
            genreImageLabel.update(
                with: .init(
                    image: .init(image: .film, tintColor: .appTextGrey, size: .init(width: 16, height: 16)),
                    title: .init(
                        text: genre,
                        font: .montserratMedium(ofSize: 12),
                        textColor: .appTextGrey,
                        numberOfLines: 0,
                        alignment: .center
                    ),
                    spacing: 4,
                    alignment: .top
                )
            )
        }
        
        ratingView.isHidden = model.rating == nil
        ratingView.update(with: .init(rating: model.rating ?? 0))
        
        ageView.isHidden = model.age == nil
        ageView.update(with: .init(text: model.age ?? "", color: .appBlue))
    }
}
