//
//  CustomSettingsView.swift
//  MovieApp
//
//  Created by Vanopr on 03.01.2024.
//

import UIKit

final class CustomSettingsView: UIView {
    
    // MARK: - Private UI Properties
    private var iconView = UIView()
    private var nameLabel = UILabel()
    
    private var arrowView: UIView = {
        let arrowView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        arrowView.tintColor = .appBlue
        return arrowView
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configure(title: "", image: UIImage())
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(title: String, image: UIImage) {
        iconView = createIconView(with: image)
        
        nameLabel = UILabel.makeLabel(
            font: .montserratMedium(ofSize: 14),
            color: .white,
            numberOfLines: 1,
            alignment: .left
        )
        nameLabel.text = title
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func createIconView(with image: UIImage) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = view.frame.height / 2
        
            let imageView = UIImageView(image: image)
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(6)
            }

        
        return view
    }
}

// MARK: - Setup UI
private extension CustomSettingsView {
    func setViews() {
        addSubviews(iconView, nameLabel, arrowView)
    }
    
    func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(36)
            make.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconView.snp.right)
                .offset(18)
            make.right.equalTo(arrowView.snp.left)
                .offset(-50)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(14)
        }
    }
}
