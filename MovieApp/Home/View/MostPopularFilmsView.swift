//
//  MostPopularFilmsView.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 1.01.24.
//

import UIKit

class MostPopularFilmsView:UIImageView{
    
    // MARK: - UI Components
    private let starTitleMostPopularFilms:UILabel = .makeLabel(font: .montserratSemiBold(ofSize: 12), color:.appOrange)
    
    private let starImageMostPopularFilms :UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "star")?.withTintColor(.appOrange, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let mostPopularFilmsStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = .appSoft.withAlphaComponent(0.72)
        starTitleMostPopularFilms.text = "4.5"
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        mostPopularFilmsStackView.addArrangedSubviews(starImageMostPopularFilms,starTitleMostPopularFilms )
        self.addSubviews(mostPopularFilmsStackView)
        
        mostPopularFilmsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mostPopularFilmsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mostPopularFilmsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mostPopularFilmsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            
        ])
    }
}
