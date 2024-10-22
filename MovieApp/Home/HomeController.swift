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
    private let profileView = ImageTitleSubtitleView()
    private let searchTextField = SearchTextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureNavBar()
        presenter.activate()
    }
    
    private func updateProfileView() {
        guard let user = presenter.fetchUser() else {
            profileView.update(with:
                    .init(
                        image:
                                .init(
                                    image: UIImage(systemName: "person.circle"),
                                    renderingMode: .alwaysOriginal,
                                    tintColor: .white,
                                    size: CGSize(width: 40, height: 40),
                                    cornerRadius: 20
                                ),
                        title: .init(
                            text: "Hello!".localized,
                            font: .montserratSemiBold(ofSize: 16),
                            textColor: .white,
                            numberOfLines: 1
                        ),
                        spacing: 16))
            return
        }
        profileView.update(with:
                .init(
                    image:
                            .init(
                                image: UIImage(data: user.image),
                                renderingMode: .alwaysOriginal,
                                tintColor: nil,
                                size: CGSize(width: 40, height: 40),
                                cornerRadius: 20
                            ),
                    title: .init(
                        text: "Hello, ".localized + user.login,
                        font: .montserratSemiBold(ofSize: 16),
                        textColor: .white,
                        numberOfLines: 1
                    ),
                    spacing: 16))
        profileView.reloadInputViews()
    }
    
    func update(with model: Model, onlyPopular: Bool) {
        builder.reloadData(model, onlyPopular)
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.height.equalTo(41)
        }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapSearch))
        searchTextField.addGestureRecognizer(tapGR)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .wishlist.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTapWishlistButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        profileView.addGestureRecognizer(tapGR)
    }
    
    @objc
    private func didTapProfile() {
        presenter.didTapProfile()
    }
    
    @objc
    private func didTapWishlistButton() {
        presenter.didTapWishlistButton()
    }
    
    @objc
    private func didTapSearch() {
        presenter.didTapSearch()
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
        
        struct Profile {
            let image: UIImage?
            let text: String
        }
        
        let categories: Categories?
        let genres: Genres?
        let popularMovies: PopularMovies?
        let profile: Profile
    }
}
