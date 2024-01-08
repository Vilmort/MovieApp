//
//  CetegoriesCell.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 1.01.24.
//

import UIKit

class CategoriesCell:UICollectionViewCell{
    
    // MARK: - Variables
    static let identifier = "CategoriesCell"
    // MARK: - UI Components
     let titleCategories = UILabel.makeLabel(font: .montserratMedium(ofSize: 18), color: .appTextWhiteGrey, numberOfLines: 0)
  
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(for category:CategoriesModel){
        layer.cornerRadius = 15
        titleCategories.text = category.title

    }
    //MARK: - UI Setup
    private func setupUI(){
        self.addSubviews(titleCategories)
        
        titleCategories.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            titleCategories.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleCategories.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleCategories.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}

