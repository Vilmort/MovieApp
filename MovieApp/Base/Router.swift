//
//  Router.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

class Router {
    weak var controller: UIViewController?
    
    func pushScreen(_ vc: UIViewController) {
        guard let controller else {
            return
        }
        if let navController = controller.navigationController {
            navController.pushViewController(vc, animated: true)
        } else {
            presentScreen(vc)
        }
    }
    
    func presentScreen(_ vc: UIViewController) {
        controller?.present(vc, animated: true)
    }
}
