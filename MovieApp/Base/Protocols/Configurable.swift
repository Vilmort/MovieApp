//
//  Configurable.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

protocol Configurable: UIView {
    associatedtype Model
    
    func update(with model: Model)
}
