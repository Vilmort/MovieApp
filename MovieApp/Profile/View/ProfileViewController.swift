//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }
}
