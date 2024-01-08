//
//  HomeViewControllerMy.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//

import UIKit

final class HomeViewControllerMy: UIViewController {
    //MARK: - Private properties
    private let collectionView: HomeViewProtocol2
    private let presenter: HomePresenterProtocolMy
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = makeDataSource()
    
    private var popularCategoriesArray:[PopularCategoriesModel] = [.firstPopularCategory,.secondPopularCategory,.thirdPopularCategory ]
    
    private var CategoriesArray:[CategoriesModel] = [.firstCategory,.secondCategory,.thirdCategory,.fourthCategory]
    private var mostPopularFilmsArray:[MostPopularFilmsModel] = [.firstPopulaFilm,
                                                    .secondPopulaFilm,
                                                    .thirdPopulaFilm]

    
    //MARK: - init(_:)
    init(
        homeView: HomeViewProtocol2,
        presenter: HomePresenterProtocolMy
    ) {
        self.collectionView = homeView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()
        dataSource.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        collectionView.collectionView.dataSource = dataSource
        collectionView.collectionView.delegate = self
        view.backgroundColor = .appDark
        presenter.viewDidLoad()
        collectionDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    @objc func seeAllCategoriesButtonTap() {

    }
    
    @objc func seeAllPopularButtonTap() {
        
    }
    
    func collectionDidLoad() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(
            popularCategoriesArray.map(Item.popularCategories),
            toSection: .categories
        )
        
        snapshot.appendItems(
            CategoriesArray.map(Item.categories),
            toSection: .genres
        )
        
        snapshot.appendItems(
            mostPopularFilmsArray.map(Item.mostPopular),
            toSection: .mostPopular
        )
        dataSource.apply(snapshot)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


//MARK: - UICollectionViewDelegate
extension HomeViewControllerMy: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.visibleCells.compactMap { $0 as? CategoriesCell }.forEach {
            $0.backgroundColor = .clear
            $0.titleCategories.textColor = .white
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell else { return }
        cell.backgroundColor = .appSoft
        cell.titleCategories.textColor = .appBlue
    }
}

extension HomeViewControllerMy {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case categories
        case genres
        case mostPopular
    }
    
     enum Item: Hashable {
        case popularCategories(PopularCategoriesModel)
        case categories(CategoriesModel)
        case mostPopular(MostPopularFilmsModel)
    }
}

private extension HomeViewControllerMy {
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let categoryCellRegistration = makeCategoryCellRegistration()
        let genreCellRegistration = makeGenreCellRegistration()
        let mostPopularCellRegistration = makeMostPopularCellRegistration()
        
        return .init(collectionView: collectionView.collectionView) { collectionView, indexPath, item in
            switch item {
            case let .popularCategories(category):
                return collectionView.dequeueConfiguredReusableCell(
                    using: categoryCellRegistration,
                    for: indexPath,
                    item: category
                )
                
            case let .categories(genre):
                return collectionView.dequeueConfiguredReusableCell(
                    using: genreCellRegistration,
                    for: indexPath,
                    item: genre
                )
                
            case let .mostPopular(mostPopular):
                return collectionView.dequeueConfiguredReusableCell(
                    using: mostPopularCellRegistration,
                    for: indexPath,
                    item: mostPopular
                )
            }
        }
    }
    
    func makeCategoryCellRegistration() -> UICollectionView.CellRegistration<PopularCategoryCell, PopularCategoriesModel> {
        .init { cell, _, category in
            cell.configure(for: category)
        }
    }
    
    func makeGenreCellRegistration() -> UICollectionView.CellRegistration<CategoriesCell, CategoriesModel> {
        .init {  cell, _, genre in
            cell.configure(for: genre)
        }
    }
    
    func makeMostPopularCellRegistration() -> UICollectionView.CellRegistration<MostPopularFilmsCell, MostPopularFilmsModel> {
        .init { cell, _, mostPopular in
            cell.configure(for: mostPopular)
        }
    }
    
    func makeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { header, elementKind, indexPath in
            switch Section(rawValue: indexPath.section) {
            case .categories:
                header.configure(title: "Categories")
                header.addButton(
                    target: self,
                    action: #selector(self.seeAllCategoriesButtonTap)
                )
            case .genres:
                header.configure(title: "Genres")
            case .mostPopular:
                header.configure(title: "Most Popular")
                header.addButton(
                    target: self,
                    action: #selector(self.seeAllPopularButtonTap)
                )
            default:
                break
            }
        }
    }
    
}








