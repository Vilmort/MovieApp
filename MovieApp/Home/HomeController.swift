//
//  HomeController.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import UIKit

final class HomeController: ViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol!
    
    private lazy var builder = HomeBuilder(collectionView)
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureNavBar()
        presenter.activate()
    }
    
    func update(with model: Model, onlyPopular: Bool) {
        builder.reloadData(model, onlyPopular)
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .wishlist.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTapWishlistButton)
        )
    }
    
    @objc
    private func didTapWishlistButton() {
        presenter.didTapWishlistButton()
    }
}

extension HomeController {
    struct Model {
        struct Category {
            let imageURL: URL?
            let title: String
            let count: String?
            let didSelectHandler: () -> Void
        }
        
        struct Categories {
            let categories: [Category]
            let seeAllHandler: () -> Void
        }
        
        struct Genre {
            let title: String
            let didSelectHandler: () -> Void
        }
        
        struct Genres {
            let genres: [Genre]
            let preselectedIndex: Int
        }
        
        struct PopularMovie {
            let imageURL: URL?
            let title: String
            let genre: String?
            let rating: Double?
            let didSelect: () -> Void
        }
        
        struct PopularMovies {
            let movies: [PopularMovie]
            let seeAllHandler: () -> Void
        }
        
        let categories: Categories?
        let genres: Genres?
        let popularMovies: PopularMovies?
    }
}
