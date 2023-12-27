//
//  CustomView.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() { }
}
