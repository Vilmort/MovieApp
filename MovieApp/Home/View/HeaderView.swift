//
//  HeaderView.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    //MARK: - Private properties
    private let titleLabel = UILabel.makeLabel(
        font: .MontserratBold(ofSize: 18),
        color: .appTextWhiteGrey
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init is not implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    //MARK: - Public Methods
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func addButton(target: AnyObject, action: Selector) {
        let seeAllButton = makeButton()
        seeAllButton.addTarget(
            target,
            action: action,
            for: .touchUpInside
        )
        addSubview(seeAllButton)
        makeConstraints(for: seeAllButton)
    }
}

private extension HeaderView {
    
    //MARK: - Private methods
    func makeButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .appBlue
        var container = AttributeContainer()
        container.font = .montserratMedium(ofSize: 16)
        configuration.attributedTitle = AttributedString("See all", attributes: container)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        let button = UIButton(configuration: configuration)
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeConstraints(for button: UIButton) {
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
}

