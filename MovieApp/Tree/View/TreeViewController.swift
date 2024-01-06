//
//  ViewController.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import UIKit

class TreeViewController: UIViewController, TreeViewProtocol {
    
    var presenter: TreePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
}
