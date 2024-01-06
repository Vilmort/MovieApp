//
//  UILabel+Extension.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

extension UILabel: Configurable {
    struct Model {
        let text: String
        let font: UIFont
        let textColor: UIColor
        let numberOfLines: Int
        let textAlignment: NSTextAlignment
        
        init(
            text: String,
            font: UIFont,
            textColor: UIColor,
            numberOfLines: Int,
            alignment: NSTextAlignment = .left
        ) {
            self.text = text
            self.font = font
            self.textColor = textColor
            self.numberOfLines = numberOfLines
            self.textAlignment = alignment
        }
    }
    
    func update(with model: Model) {
        text = model.text
        font = model.font
        textColor = model.textColor
        numberOfLines = model.numberOfLines
        textAlignment = model.textAlignment
    }
}
