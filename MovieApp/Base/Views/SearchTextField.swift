//
//  SearchTextField.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

final class SearchTextField: UITextField {
    
    var changeTextHandler: ((String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 48, y: 0, width: bounds.width - 64, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 48, y: 0, width: bounds.width - 64, height: bounds.height)
    }
    
    private func configure() {
        let leftView = UIView()
        let iv = UIImageView()
        iv.update(with: .init(image: .search, tintColor: .appTextGrey))
        leftView.addSubview(iv)
        iv.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(16)
        }
        self.leftView = leftView
        self.leftViewMode = .always
        self.attributedPlaceholder = NSAttributedString(
            string: "Search movie or artist...".localized,
            attributes: [.font: UIFont.montserratMedium(ofSize: 14), .foregroundColor: UIColor.appTextGrey]
        )
        self.backgroundColor = .appSoft
        self.tintColor = .appTextGrey
        self.font = .montserratMedium(ofSize: 14)
        self.textColor = .white
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.returnKeyType = .done
        self.addTarget(self, action: #selector(didChangeValue(_:)), for: .editingChanged)
    }
    
    @objc
    private func didChangeValue(_ textField: UITextField) {
        changeTextHandler?(textField.text)
    }
}
