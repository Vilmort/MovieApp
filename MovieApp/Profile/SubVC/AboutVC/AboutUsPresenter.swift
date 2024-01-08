//
//  AboutPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation

protocol AboutViewControllerProtocol: AnyObject {
    
}

protocol AboutUsPresenterProtocol: AnyObject {
    
}

final class AboutUsPresenter: AboutUsPresenterProtocol {
    weak var view: AboutViewControllerProtocol?
    init(view: AboutViewControllerProtocol? = nil) {
        self.view = view
    }
    
}
