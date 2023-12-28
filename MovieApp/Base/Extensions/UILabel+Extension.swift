//
//  UILabel+Extension.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

extension UILabel: Configurable {
    struct Model {
        let text: NSAttributedString
        let numberOfLines: Int
        let textAlignment: NSTextAlignment
        
        init(
            text: NSAttributedString,
            numberOfLines: Int,
            textAlignment: NSTextAlignment = .left
        ) {
            self.text = text
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
        }
        
        init(
            text: String,
            font: UIFont,
            textColor: UIColor,
            numberOfLines: Int,
            alignment: NSTextAlignment = .left
        ) {
            self.text = NSAttributedString(
                string: text,
                attributes: [.font: font, .foregroundColor: textColor]
            )
            self.numberOfLines = numberOfLines
            self.textAlignment = alignment
        }
    }
    
    func update(with model: Model?) {
        guard let model else {
            attributedText = nil
            return
        }
        attributedText = model.text
        numberOfLines = model.numberOfLines
        textAlignment = model.textAlignment
    }
}
