//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit


extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
