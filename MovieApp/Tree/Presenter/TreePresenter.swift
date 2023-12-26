//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 26.12.2023.
//

import Foundation

protocol TreeViewProtocol: AnyObject {

}

protocol TreePresenterProtocol: AnyObject {
    init(view: TreeViewProtocol)
}

final class TreePresenter: TreePresenterProtocol {
    weak var view: TreeViewProtocol?
   
    required init(view: TreeViewProtocol) {
        self.view = view
    }
    
}
