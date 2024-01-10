//
//  HomeController.swift
//  MovieApp
//
//  Created by Victor Rubenko on 10.01.2024.
//

import UIKit

final class HomeController: ViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol!
    
    private lazy var collectionView: UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter.activate()
    }
    
    private func configure() {
        
    }
}

extension HomeController {
    struct Model {
        struct Category {
            let imageURL: URL?
            let title: String
            let count: String
            let didSelectHandler: () -> Void
        }
        
        struct GenrePicker {
            let genres: [String]
            let didSelectHandler: () -> Void
            let seeAllHandler: () -> Void
        }
    }
    
    enum Section {
        case space(height: CGFloat)
        case categories
        case genre
        case popular
    }
}
