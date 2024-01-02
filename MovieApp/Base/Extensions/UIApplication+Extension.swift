//
//  UIApplication+Extension.swift
//  MovieApp
//
//  Created by Victor on 02.01.2024.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .last { $0.isKeyWindow }
    }
}
