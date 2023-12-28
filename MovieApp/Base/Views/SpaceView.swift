//
//  SpaceView.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

final class SpaceView: UIView, Configurable {
    
    struct Model {
        let height: CGFloat
    }
    
    func update(with model: Model?) {
        snp.makeConstraints {
            $0.height.equalTo(model?.height ?? 0)
        }
    }
}
