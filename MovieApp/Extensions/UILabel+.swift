//
//  UILabel+.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit

extension UILabel {
    static func makeLabel(
        font: UIFont?,
        color: UIColor?,
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
