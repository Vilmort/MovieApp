//
//  UIView+Extension.swift
//  MovieApp
//
//  Created by Victor on 01.01.2024.
//

import UIKit

extension UIView {
    func markAsSpoiler() {
        guard !subviews.contains(where: { $0 is SpoilerView }) else {
            return
        }
        let view = SpoilerView()
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
