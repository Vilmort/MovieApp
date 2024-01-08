//
//  HomePresenterMy.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//

import Foundation

//MARK: - HomePresenterProtocol
protocol HomePresenterProtocolMy: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
    func didSelectReceipt(at indexPath: IndexPath)
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {

}

final class HomePresenterMy: HomePresenterProtocolMy {
    func viewDidLoad() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectReceipt(at indexPath: IndexPath) {
        
    }
    
}
