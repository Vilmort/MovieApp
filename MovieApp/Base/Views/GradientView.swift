//
//  GradientView.swift
//  MovieApp
//
//  Created by Victor on 02.01.2024.
//

import UIKit

final class GradientView: CustomView {
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
}

extension GradientView: Configurable {
    struct Model {
        let colors: [UIColor]
        let startPoint: CGPoint
        let endPoint: CGPoint
        let locations: [NSNumber]?
    }
    
    func update(with model: Model?) {
        guard let layer = self.layer as? CAGradientLayer else {
            return
        }
        
        guard let model else {
            layer.colors = []
            return
        }
        
        layer.startPoint = model.startPoint
        layer.endPoint = model.endPoint
        layer.locations = model.locations
        layer.colors = model.colors.map { $0.cgColor }
    }
}
