//
//  LoadingView.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit
import Lottie
import SnapKit

final class LoadingView: CustomView {
    let animation = LottieAnimationView()
    
    override func configure() {
        animation.animation = .filepath(Bundle.main.path(forResource: "loading", ofType: "json") ?? "")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .autoReverse
        
        addSubview(animation)
        
        animation.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.center.equalToSuperview()
        }
    }
}
