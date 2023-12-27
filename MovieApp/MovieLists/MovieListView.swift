//
//  ListView.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit
import Kingfisher

final class MovieListView: CustomView {
    private let imageView = UIImageView()
    private let label = UILabel()
    private let blurView = {
        let effect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: effect)
        return blurView
    }()
    
    override func configure() {
        addSubview(imageView)
        addSubview(blurView)
        addSubview(label)
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.leading.greaterThanOrEqualToSuperview().inset(16)
            $0.bottom.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        blurView.layer.cornerRadius = 4
        blurView.clipsToBounds = true
        blurView.snp.makeConstraints {
            $0.edges.equalTo(label).inset(-4)
        }
    }
}

extension MovieListView: Configurable {
    struct Model {
        let name: String
        let imageURL: URL?
    }
    
    func update(with model: Model) {
        label.update(with: .init(text: model.name, font: .montserratSemiBold(ofSize: 18), textColor: .white, numberOfLines: 3, alignment: .center))
        imageView.kf.setImage(with: model.imageURL)
    }
}
