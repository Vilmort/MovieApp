//
//  Search.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController, SearchViewProtocol {
    
    var presenter: SearchPresenterProtocol!

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
