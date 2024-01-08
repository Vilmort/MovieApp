//
//  UserCell.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit


final class TeamViewCell: UICollectionViewCell {
    
    
    // MARK: - Private UI Properties
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .montserratMedium(ofSize: 14),
            color: .white,
            numberOfLines: 1,
            alignment: .left)
        label.text = "Login"
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .montserratMedium(ofSize: 14),
            color: .white,
            numberOfLines: 1,
            alignment: .left)
        label.text = "Email"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    // MARK: - Public Methods
    func configure(with team: TeamPayer) {
        profileImageView.image = team.image
        userNameLabel.text = team.role
        userEmailLabel.text = team.gitHub
    }
}

// MARK: - Setup UI
private extension TeamViewCell {
    func setViews() {
        addSubviews(profileImageView, userNameLabel, userEmailLabel)
    }
    
    func setupMainView() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.appTextGrey.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(12)
            make.left.equalToSuperview()
                .offset(16)
            make.bottom.equalToSuperview()
                .offset(-12)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(21)
            make.left.equalTo(profileImageView.snp.right)
                .offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
                .offset(8)
            make.left.equalTo(profileImageView.snp.right)
                .offset(16)
            make.right.equalToSuperview()
                .offset(-16)
        }
    }
}
