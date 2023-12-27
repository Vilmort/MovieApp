//
//  ErrorPresenting.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

protocol ErrorPresenting {
    func showError(
        _ title: String,
        message: String?,
        actionTitle: String?,
        action: ((UIView) -> Void)?
    )
}
