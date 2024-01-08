//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit

final class LanguageCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let reuseID = String(describing: LanguageCell.self)
    
    // MARK: - Private UI Properties
    private lazy var mainLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .montserratSemiBold(ofSize: 16),
            color: .white,
            numberOfLines: 1
        )
        label.text = "English"
        return label
    }()
    
    private var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .appTextGrey.withAlphaComponent(0.5)
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .appBlue
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Private Properties
    private var isChecked = false {
        didSet {
            checkmarkImageView.isHidden = !isChecked
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with language: String) {
        mainLabel.text = language
    }
    
    func setCheckmarkValue(_ value: Bool) {
        isChecked = value
    }
}

// MARK: - Setup UI
private extension LanguageCell {
    func setViews() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews(mainLabel, lineView, checkmarkImageView)
    }
    
    func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
                .offset(35)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
                .inset(20)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel.snp.centerY)
            make.right.equalToSuperview()
                .offset(-25)
        }
    }
}
