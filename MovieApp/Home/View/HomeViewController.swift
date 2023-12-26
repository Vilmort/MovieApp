//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}
