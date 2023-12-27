//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 27.12.2023.
//

import UIKit
import SnapKit

class OnboardingView: UIView {
    
    //MARK: - UI Elements
    
    private let onboardingTextTitle = UILabel.makeLabel(font: .MontserratBold(ofSize: 22), color: .white, numberOfLines: 0)
    
    private let onboardingTextDescription = UILabel.makeLabel(font: .montserratRegular(ofSize: 16), color: .appTextWhiteGrey, numberOfLines: 0)
    
    
    private let onboardingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()

    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(onboardingImage,onboardingTextTitle, onboardingTextDescription)
        setLabels()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func configureOnboarding(title: String, description: String, image: UIImage) {
        onboardingTextTitle.text = title
        onboardingImage.image = image
        onboardingTextDescription.text = description
    }
    
    
    func setPageLabelTransform(transform: CGAffineTransform) {
        onboardingImage.transform = transform
    }
    
    //MARK: - Methods
    private func setLabels() {
        onboardingTextTitle.layer.backgroundColor = UIColor.appDark.cgColor
        onboardingTextDescription.layer.backgroundColor = UIColor.appDark.cgColor
        onboardingTextTitle.layer.cornerRadius = 25
        onboardingTextDescription.adjustsFontSizeToFitWidth = true
        onboardingTextDescription.minimumScaleFactor = 0.5
    }
    private func setConstraints() {
            
            onboardingImage.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(80)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(350)
            }

            onboardingTextTitle.snp.makeConstraints { make in
                make.top.equalTo(onboardingImage.snp.bottom).inset(-5)
                make.leading.equalToSuperview().offset(5)
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(80)
            }
        
        onboardingTextDescription.snp.makeConstraints { make in
            make.top.equalTo(onboardingTextTitle.snp.bottom).inset(-5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}
