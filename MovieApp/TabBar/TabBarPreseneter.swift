//
//  TabBarPreseneter.swift
//  MovieApp
//
//  Created by Vanopr on 24.12.2023.
//

import Foundation


//MARK: - Protocols
protocol TabBarViewProtocol: AnyObject {}

protocol TabBarPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
}

//MARK: - TabBarPresenter
final class TabBarPresenter: TabBarPresenterProtocol {
    
    //MARK: - Properties
    weak var view: TabBarViewProtocol?
    
    //MARK: - Init
    required init(view: TabBarViewProtocol) {
        self.view = view
    }
    
    
}
