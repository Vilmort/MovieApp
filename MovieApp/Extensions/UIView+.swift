//
//  UIView+.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
