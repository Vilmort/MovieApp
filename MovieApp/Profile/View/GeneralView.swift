//
//  GeneralView.swift
//  MovieApp
//
//  Created by Vanopr on 03.01.2024.
//

import UIKit


final class GeneralView: UIView {
    
    // MARK: - Closures
    var onFirstTap: (() -> Void)?
    var onSecondTap: (() -> Void)?
    
    // MARK: - Private UI Properties
    private var titleLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .montserratSemiBold(ofSize: 18),
            color: .white,
            numberOfLines: 1,
            alignment: .left
        )
        return label
    }()
    
    private var firstView: CustomSettingsView = {
        CustomSettingsView()
    }()
    
    private var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .appTextGrey.withAlphaComponent(0.3)
        return view
    }()
    
    private var secondView: CustomSettingsView = {
        CustomSettingsView()
    }()
    
    // MARK: - Init
    init(
        frame: CGRect,
        title: String,
        firstTitle: String,
        firstImage: UIImage,
        secondTitle: String,
        secondImage: UIImage
    )
    {
        super.init(frame: frame)
        titleLabel.text = title
        firstView.configure(title: firstTitle, image: firstImage)
        secondView.configure(title: secondTitle, image: secondImage)
        setViews()
        setupConstraints()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addTapGesture() {
        let firstTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(firstTapped)
        )
        firstView.addGestureRecognizer(firstTapGesture)
        firstView.isUserInteractionEnabled = true
        
        let secondTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(secondTapped)
        )
        secondView.addGestureRecognizer(secondTapGesture)
        secondView.isUserInteractionEnabled = true
    }
    
    // MARK: - Private Actions
    @objc private func firstTapped() {
        onFirstTap?()
    }
    
    @objc private func secondTapped() {
        onSecondTap?()
    }
}

// MARK: - Setup UI
private extension GeneralView {
    func setViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.appTextGrey.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        addSubviews(titleLabel, firstView, lineView, secondView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(15)
            make.left.equalToSuperview()
                .offset(20)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(1)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(40)
        }
    }
    
}
