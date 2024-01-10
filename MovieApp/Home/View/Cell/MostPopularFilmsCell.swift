//
//  MostPopularCell.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 1.01.24.
//

import UIKit
import KPNetwork
import Kingfisher
class MostPopularFilmsCell:UICollectionViewCell{
    
    // MARK: - Variables
    static let identifier = "MostPopularFilmsCell"
    // MARK: - UI Components
    private let titleMostPopularFilms = UILabel.makeLabel(font: .montserratSemiBold(ofSize: 14), color: .white, numberOfLines: 2)
    private let subtitleMostPopularFilms  = UILabel.makeLabel(font: .montserratMedium(ofSize: 10), color: .appTextGrey)
    private let imageMostPopularFilms :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let starImageMostPopularFilms = MostPopularFilmsView(frame: .zero)
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with category:KPMovieSearchEntity.KPSearchMovie){
        titleMostPopularFilms.text = category.name
        subtitleMostPopularFilms.text = category.genres?[0].name?.capitalized
        if let urlString = category.poster?.previewUrl{
            let url = URL(string: urlString)
            let image = imageMostPopularFilms.kf.setImage(with: url)
            
        }
        if let rating = category.rating?.kp{
            starImageMostPopularFilms.starTitleMostPopularFilms.text = String(format: "%.1f", rating)
        }
        
    }
    //MARK: - UI Setup
    private func setupUI(){
        self.addSubviews(titleMostPopularFilms,subtitleMostPopularFilms,imageMostPopularFilms,starImageMostPopularFilms)
        
        titleMostPopularFilms.translatesAutoresizingMaskIntoConstraints = false
        subtitleMostPopularFilms.translatesAutoresizingMaskIntoConstraints = false
        imageMostPopularFilms.translatesAutoresizingMaskIntoConstraints = false
        starImageMostPopularFilms.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageMostPopularFilms.topAnchor.constraint(equalTo: self.topAnchor),
            imageMostPopularFilms.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageMostPopularFilms.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageMostPopularFilms.heightAnchor.constraint(equalToConstant: 178),
            
            titleMostPopularFilms.topAnchor.constraint(equalTo: imageMostPopularFilms.bottomAnchor,constant: 10),
            titleMostPopularFilms.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            titleMostPopularFilms.widthAnchor.constraint(equalToConstant: 120),
            titleMostPopularFilms.heightAnchor.constraint(equalToConstant: 17),
            
            subtitleMostPopularFilms.topAnchor.constraint(equalTo: titleMostPopularFilms.bottomAnchor, constant: 5),
            subtitleMostPopularFilms.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            subtitleMostPopularFilms.widthAnchor.constraint(equalToConstant: 120),
            subtitleMostPopularFilms.heightAnchor.constraint(equalToConstant: 12),
            
            starImageMostPopularFilms.topAnchor.constraint(equalTo: imageMostPopularFilms.topAnchor,constant: 8),
            starImageMostPopularFilms.leadingAnchor.constraint(equalTo: imageMostPopularFilms.leadingAnchor,constant: 72),
            starImageMostPopularFilms.widthAnchor.constraint(equalToConstant: 55),
            starImageMostPopularFilms.heightAnchor.constraint(equalToConstant: 24),
 
        ])
    }
}

