//
//  NavigationAndSearchBarView.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 10.01.24.
//

import Foundation
import UIKit
protocol NavigationAndSearchBarViewProtocol: UIView {
    var navigationAndSearchBarView: UIView { get }
}
final class NavigationAndSearchBarView:UIView, NavigationAndSearchBarViewProtocol{
    var navigationAndSearchBarView: UIView = makeNavigationAndSearchBarView()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appDark
        addSubviews(
            navigationAndSearchBarView
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
}
private extension NavigationAndSearchBarView{
    //MARK: - Private methods
    static func makeNavigationAndSearchBarView()->UIView{
         let imageNavigationBar:UIImageView = {
            let image = UIImageView(image: UIImage(named:"imageNavigationBar"))
            image.backgroundColor = .white
            image.layer.cornerRadius = 20
            image.clipsToBounds = true
            return image
        }()
         let labelNavigationBar:UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .left
            label.text = "Hello,Smith"
            label.sizeToFit()
            label.font = .montserratSemiBold(ofSize: 16)
            return label
        }()
         let heartButtonNavigationBar:UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 10
            button.setTitleColor(.appBlue, for: .normal)
            button.setImage(UIImage(named: "heart"), for: .normal)
            button.backgroundColor = .appSoft
            button.setImage(button.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .appRed
            return button
        }()
        
         let searchBar:UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.searchBarStyle = .minimal
            searchBar.clipsToBounds = true
            searchBar.searchTextField.layer.cornerRadius = 10
            searchBar.searchTextField.textColor = .white
            searchBar.searchTextField.tintColor = .white
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a title ...", attributes: [.foregroundColor:UIColor.appTextGrey,.font:UIFont.montserratMedium(ofSize: 14)])
            searchBar.searchTextField.clearButtonMode = .whileEditing
            if let clearButton = searchBar.searchTextField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                       clearButton.tintColor = .appTextGrey
                   }
            if let glassIconView = searchBar.searchTextField.leftView as? UIImageView {
                        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                        glassIconView.tintColor = .appTextGrey
                    }
            return searchBar
        }()
        
        return searchBar
    }
    
    func setupConstraints() {
        navigationAndSearchBarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
