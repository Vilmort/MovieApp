//
//  PopularCategoryCell.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 29.12.23.
//

import UIKit

class PopularCategoryCell:UICollectionViewCell{
    
    // MARK: - Variables
    static let identifier = "PopularCategoryCell"
    // MARK: - UI Components
    private let titlePopularCategory = UILabel.makeLabel(font: .montserratSemiBold(ofSize: 16), color: .white, numberOfLines: 0)
    private let countPopularCategory = UILabel.makeLabel(font: .montserratMedium(ofSize: 12), color: .appTextWhiteGrey)
    private let imagePopularCategory:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(for category:PopularCategoriesModel){
        titlePopularCategory.text = category.title
        countPopularCategory.text = category.subTitle
        imagePopularCategory.image = UIImage(named: category.image)
    }
    //MARK: - UI Setup
    private func setupUI(){
        self.addSubviews(imagePopularCategory,titlePopularCategory,countPopularCategory)
        
        imagePopularCategory.translatesAutoresizingMaskIntoConstraints = false
        titlePopularCategory.translatesAutoresizingMaskIntoConstraints = false
        countPopularCategory.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imagePopularCategory.topAnchor.constraint(equalTo: self.topAnchor),
            imagePopularCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePopularCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imagePopularCategory.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titlePopularCategory.topAnchor.constraint(equalTo: self.topAnchor,constant: 80),
            titlePopularCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            titlePopularCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titlePopularCategory.heightAnchor.constraint(equalToConstant: 20),
            
            countPopularCategory.topAnchor.constraint(equalTo: titlePopularCategory.bottomAnchor, constant: 44),
            countPopularCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            countPopularCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            countPopularCategory.heightAnchor.constraint(equalToConstant: 15)
 
        ])
    }
}
