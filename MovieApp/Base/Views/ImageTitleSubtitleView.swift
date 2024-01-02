//
//  ImageLabelView.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class ImageTitleSubtitleView: CustomView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stack = UIStackView()
    private let textStack = UIStackView()
    
    override func configure() {
        addSubview(stack)
        stack.addArrangedSubviews(imageView, textStack)
        
        textStack.axis = .vertical
        textStack.addArrangedSubviews(titleLabel, subtitleLabel)
        
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ImageTitleSubtitleView: Configurable {
    struct Model {
        let image: UIImageView.Model
        let title: UILabel.Model
        let subtitle: UILabel.Model?
        let spacing: CGFloat
        let alignment: UIStackView.Alignment
        let axis: NSLayoutConstraint.Axis
        
        init(
            image: UIImageView.Model,
            title: UILabel.Model,
            subtitle: UILabel.Model? = nil,
            spacing: CGFloat,
            alignment: UIStackView.Alignment = .center,
            axis: NSLayoutConstraint.Axis = .horizontal
        ) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
            self.spacing = spacing
            self.alignment = alignment
            self.axis = axis
        }
    }
    
    func update(with model: Model?) {
        guard let model else {
            titleLabel.text = nil
            subtitleLabel.text = nil
            imageView.image = nil
            return
        }
        stack.alignment = model.alignment
        stack.spacing = model.spacing
        stack.axis = model.axis
        
        titleLabel.update(with: model.title)
        subtitleLabel.update(with: model.subtitle)
        imageView.update(with: model.image)
        
        subtitleLabel.isHidden = model.subtitle == nil
    }
}
