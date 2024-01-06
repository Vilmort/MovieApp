//
//  MostPopularHeaderView.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 1.01.24.
//


import UIKit

class MostPopularHeaderView:UICollectionReusableView{
    var seeAllCategoriesButtonDidTapped:(()->Void)?
    static let identifier = "MostPopularHeaderView"
    // MARK: - UI Components
    let title = UILabel.makeLabel(font: .montserratSemiBold(ofSize: 16), color: .white)
    lazy var seeAllCategoriesButton:UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .appDark
        button.setTitleColor(.appBlue, for: .normal)
        button.titleLabel?.font = UIFont.montserratMedium(ofSize: 14)
        button.addAction(UIAction(handler: { [unowned self] _ in
            self.seeAllCategoriesButtonDidTapped?()
        }), for: .touchUpInside)
        return button
    }()
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        stackView.addArrangedSubviews(title,seeAllCategoriesButton )
        self.addSubviews(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


