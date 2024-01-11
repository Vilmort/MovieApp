//
//  HomeMovieView.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

final class HomeMovieView: CustomView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let genreLabel = UILabel()
    
    override func configure() {
        backgroundColor = .appSoft
        
        addSubviews(imageView, nameLabel, genreLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(nameLabel)
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.greaterThanOrEqualTo(12)
        }
    }
}

extension HomeMovieView: Configurable {
    struct Model {
        let image: UIImageView.Model
        let name: UILabel.Model
        let genre: UILabel.Model
    }
    
    func update(with model: Model?) {
        imageView.update(with: model?.image)
        nameLabel.update(with: model?.name)
        genreLabel.update(with: model?.genre)
    }
}
