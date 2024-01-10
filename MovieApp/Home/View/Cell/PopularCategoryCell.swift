//
//  PopularCategoryCell.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 29.12.23.
//

import UIKit
import KPNetwork
import Kingfisher

class PopularCategoryCell:UICollectionViewCell{
    
    // MARK: - Variables
    static let identifier = "PopularCategoryCell"
    // MARK: - UI Components
    private let titlePopularCategory = UILabel.makeLabel(font: .MontserratBold(ofSize: 20), color: .white, numberOfLines: 0, alignment: .left)
    
    private let countPopularCategory = UILabel.makeLabel(font: .montserratMedium(ofSize: 16), color: .appTextWhiteGrey, alignment: .left)
    

    private var imagePopularCategory: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        titlePopularCategory.backgroundColor = .appBlue.withAlphaComponent(0.5)
        titlePopularCategory.layer.cornerRadius = 10
        countPopularCategory.backgroundColor = .appSoft.withAlphaComponent(0.5)
        countPopularCategory.layer.cornerRadius = 10

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category:KPListSearchEntity.KPList){
        titlePopularCategory.text = category.name
        countPopularCategory.text = (category.moviesCount?.description ?? "43") + " " + "films"
        if let urlString = category.cover?.url,
           let url = URL(string: urlString) {
            imagePopularCategory.kf.setImage(with: url)
        }
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
            titlePopularCategory.heightAnchor.constraint(equalToConstant: 30),
            
            countPopularCategory.topAnchor.constraint(equalTo: titlePopularCategory.bottomAnchor, constant: 44),
            countPopularCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            countPopularCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            countPopularCategory.heightAnchor.constraint(equalToConstant: 15)
 
        ])
    }
}
