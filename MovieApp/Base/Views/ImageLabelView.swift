//
//  ImageLabelView.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

final class ImageLabelView: CustomView {
    private let imageView = UIImageView()
    private let label = UILabel()
    private let stack = UIStackView()
    
    override func configure() {
        addSubview(stack)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ImageLabelView: Configurable {
    struct Model {
        let text: UILabel.Model
        let image: UIImageView.Model
        let spacing: CGFloat
        let alignment: UIStackView.Alignment
        
        init(
            text: UILabel.Model,
            image: UIImageView.Model,
            spacing: CGFloat,
            alignment: UIStackView.Alignment = .center
        ) {
            self.text = text
            self.image = image
            self.spacing = spacing
            self.alignment = alignment
        }
    }
    
    func update(with model: Model?) {
        guard let model else {
            label.text = nil
            imageView.image = nil
            return
        }
        stack.alignment = model.alignment
        stack.spacing = model.spacing
        
        label.update(with: model.text)
        imageView.update(with: model.image)
    }
}
