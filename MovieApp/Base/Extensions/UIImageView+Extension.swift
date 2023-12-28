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
        let renderingMode: UIImage.RenderingMode
        let tintColor: UIColor?
        let contenMode: UIImageView.ContentMode
        let size: CGSize?
        
        init(
            image: UIImage?,
            renderingMode: UIImage.RenderingMode = .alwaysTemplate,
            tintColor: UIColor?,
            contenMode: UIImageView.ContentMode = .scaleAspectFit,
            size: CGSize? = nil
        ) {
            self.image = image
            self.renderingMode = renderingMode
            self.tintColor = tintColor
            self.contenMode = contenMode
            self.size = size
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
        
        if let size = model.size {
            snp.remakeConstraints {
                $0.size.equalTo(size)
            }
        }
    }
}
