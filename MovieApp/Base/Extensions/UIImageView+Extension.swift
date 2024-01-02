//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

extension UIImageView: Configurable {
    struct Model {
        let image: UIImage?
        let url: URL?
        let renderingMode: UIImage.RenderingMode
        let tintColor: UIColor?
        let contenMode: UIImageView.ContentMode
        let size: CGSize?
        let cornerRadius: CGFloat
        
        init(
            image: UIImage?,
            url: URL? = nil,
            renderingMode: UIImage.RenderingMode = .alwaysTemplate,
            tintColor: UIColor?,
            contenMode: UIImageView.ContentMode = .scaleAspectFill,
            size: CGSize? = nil,
            cornerRadius: CGFloat = .zero
        ) {
            self.image = image
            self.url = url
            self.renderingMode = renderingMode
            self.tintColor = tintColor
            self.contenMode = contenMode
            self.size = size
            self.cornerRadius = cornerRadius
        }
    }
    
    func update(with model: Model?) {
        guard let model else {
            self.image = nil
            return
        }
        self.image = model.image?.withRenderingMode(model.renderingMode)
        self.tintColor = model.tintColor
        self.contentMode = model.contenMode
        self.clipsToBounds = true 
        self.layer.cornerRadius = model.cornerRadius
        
        if let size = model.size {
            snp.remakeConstraints {
                $0.size.equalTo(size)
            }
        }
        
        if let url = model.url {
            self.kf.setImage(with: url)
        }
    }
}
