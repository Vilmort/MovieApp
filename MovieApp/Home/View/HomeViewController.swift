
//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewProtocol {
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection,HomeItem>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeSection,HomeItem>
    
    // MARK: - Variables
    var presenter: HomePresenterProtocol!
    private var dataSource:DataSource?
    private var snapshot = DataSourceSnapshot()
    private var popularCategoriesArray:[HomeItem] = [.popularCategories(.firstPopularCategory),
                                                     .popularCategories(.secondPopularCategory),
                                                     .popularCategories(.thirdPopularCategory)
    ]
    private var CategoriesArray:[HomeItem] = [.categories(.firstCategory),
                                              .categories(.secondCategory),
                                              .categories(.thirdCategory),
                                              .categories(.fourthCategory)
    ]
    private var mostPopularFilmsArray:[HomeItem] = [.mostPopular(.firstPopulaFilm),
                                                    .mostPopular(.secondPopulaFilm),
                                                    .mostPopular(.thirdPopulaFilm)]

    // MARK: - UI Components
    private let imageNavigationBar:UIImageView = {
        let image = UIImageView(image: UIImage(named:"imageNavigationBar"))
        image.backgroundColor = .white
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    private let labelNavigationBar:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Hello,Smith"
        label.sizeToFit()
        label.font = .montserratSemiBold(ofSize: 16)
        return label
    }()
    private let heartButtonNavigationBar:UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.appBlue, for: .normal)
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.backgroundColor = .appSoft
        button.setImage(button.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .appRed
        return button
    }()
    
    private let searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.clipsToBounds = true
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a title ...", attributes: [.foregroundColor:UIColor.appTextGrey,.font:UIFont.montserratMedium(ofSize: 14)])
        searchBar.searchTextField.clearButtonMode = .whileEditing
        if let clearButton = searchBar.searchTextField.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                   clearButton.tintColor = .appTextGrey
               }
        if let glassIconView = searchBar.searchTextField.leftView as? UIImageView {
                    glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                    glassIconView.tintColor = .appTextGrey
                }
        return searchBar
    }()
    private lazy var homeCollectionView:UICollectionView = {
        let layout = UICollectionViewLayout()
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.headerMode = .supplementary
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(PopularCategoryCell.self, forCellWithReuseIdentifier: PopularCategoryCell.identifier)
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        collectionView.register(MostPopularFilmsCell.self, forCellWithReuseIdentifier: MostPopularFilmsCell.identifier)
        collectionView.backgroundColor = .appDark
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appDark
        homeCollectionView.collectionViewLayout = createLayout()
        setupUI()
        makeDataSource()
        appleSnapshot()
    }
    private func appleSnapshot(){
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.popularCategories,.categories,.mostPopular])
        snapshot.appendItems(popularCategoriesArray, toSection: .popularCategories)
        snapshot.appendItems(CategoriesArray, toSection: .categories)
        snapshot.appendItems(mostPopularFilmsArray, toSection: .mostPopular)
        dataSource?.apply(snapshot,animatingDifferences: false)
    }
    
    //MARK: - Create Composition Layout
    private func createLayout()->UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sections = HomeSection.allCases[sectionIndex]
            self.homeCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
            switch sections{
                
            case .popularCategories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(175))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
                
                let popularCetegoriesHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

                self.dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
                    guard elementKind == UICollectionView.elementKindSectionHeader else {return nil}
                    let view = self.homeCollectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView
                    let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
                    view!.title.text = section?.title
                    
                    return view
                }
                section.boundarySupplementaryItems.append(popularCetegoriesHeader)
                return section
                //                let headerRegistration = UICollectionView.SupplementaryRegistration<CustomHeaderView>(elementKind: CustomHeaderView.identifier) { supplementaryView, elementKind, indexPath in
                //
                //                    supplementaryView.title.text = "Categories"
                //                    supplementaryView.seeAllCategoriesButtonDidTapped = {
                //                        print("button tap 1")
                //                    }
                //                }
                //                self.dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
                //                    collectionView.dequeueConfiguredReusableSupplementary(using:headerRegistration, for: indexPath)
                //                }
                //let layout = UICollectionViewCompositionalLayout(section: section)
            case .categories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 5
                section.contentInsets = .init(top: 15, leading: 0, bottom: 5, trailing: 0)
                let categoriesHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                self.dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
                    guard elementKind == UICollectionView.elementKindSectionHeader else {return nil}
                    let view = self.homeCollectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView
                    let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
                    view!.title.text = section?.title
                    let button = view?.seeAllCategoriesButton
                    button?.setTitle("", for: .normal)
                    return view
                }
                section.boundarySupplementaryItems.append(categoriesHeader)
                return section
                //                let categoriesHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: CustomHeaderView.identifier, alignment: .top)
                //                let headerRegistration = UICollectionView.SupplementaryRegistration<CustomHeaderView>(elementKind: CustomHeaderView.identifier) { supplementaryView, elementKind, indexPath in
                //                    supplementaryView.title.text = "Categories"
                //                    supplementaryView.seeAllCategoriesButtonDidTapped = {
                //                        print("button tap 1")
                //                    }
                //                }
                //                  self.popularCategoriesCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
                //let layout = UICollectionViewCompositionalLayout(section: section)
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(231))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
                let mostPopularFilmsHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                self.dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
                    guard elementKind == UICollectionView.elementKindSectionHeader else {return nil}
                    let view = self.homeCollectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView
                    let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
                    view!.title.text = section?.title
                    let button = UIButton()
                    return view
                }
                section.boundarySupplementaryItems.append(mostPopularFilmsHeader)
                return section
                //                let mostPopularFilmsHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: CustomHeaderView.identifier, alignment: .top)
                //                let headerMostPopularFilmsRegistration = UICollectionView.SupplementaryRegistration<CustomHeaderView>(elementKind: CustomHeaderView.identifier) { supplementaryView, elementKind, indexPath in
                //                    supplementaryView.title.text = "Most Popular"
                //                    supplementaryView.seeAllCategoriesButtonDidTapped = {
                //                        print("button tap 2")
                //                    }
                //                }
                //                self.dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
                //                    return collectionView.dequeueConfiguredReusableSupplementary(using:headerMostPopularFilmsRegistration, for: indexPath)
                //                }
                                //let layout = UICollectionViewCompositionalLayout(section: section)
            }
        }
}
    
    //MARK: - Make DataSource
    func makeDataSource(){
        dataSource = DataSource(collectionView:homeCollectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier{
            case.popularCategories(let model):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCell.identifier, for: indexPath) as? PopularCategoryCell else {return UICollectionViewCell()}
//                cell.configure(for: model)
                cell.layer.cornerRadius = 16
                cell.backgroundColor = .appBlue
                return cell
            case .categories(let model):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {return UICollectionViewCell()}
//                cell.configure(for: model)
                cell.layer.cornerRadius = 8
                cell.backgroundColor = .appGreen
                return cell
            case .mostPopular(let model):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularFilmsCell.identifier, for: indexPath) as? MostPopularFilmsCell else {return UICollectionViewCell()}
                cell.configure(for: model)
                cell.layer.cornerRadius = 12
                cell.backgroundColor = .white
                return cell
            }
            
        }
//        let headerRegistration = UICollectionView.SupplementaryRegistration<CustomHeaderView>(elementKind: HomeViewController.sectionHeaderElementKind) { supplementaryView, elementKind, indexPath in
//            supplementaryView.title.text = elementKind
//            supplementaryView.seeAllCategoriesButtonDidTapped = {
//                print("button tap")
//            }
//        }
//        dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
//            return collectionView.dequeueConfiguredReusableSupplementary(using:headerRegistration, for: indexPath)
//        }
    }
//    func  headerRegistration(section:HomeSection){
//        switch section{
//        case .popularCategories:
//            return
//        case .categories:
//
//        case .mostPopular:
//            let headerRegistration = UICollectionView.SupplementaryRegistration<CustomHeaderView>(elementKind: HomeViewController.mostPopularFilmsHeaderElementKind) { supplementaryView, elementKind, indexPath in
//                supplementaryView.title.text = elementKind
//                supplementaryView.seeAllCategoriesButtonDidTapped = {
//                    print("button tap 2")
//                }
//            }
//            dataSource?.supplementaryViewProvider = { (collectionView,elementKind,indexPath)->UICollectionReusableView? in
//                return collectionView.dequeueConfiguredReusableSupplementary(using:headerRegistration, for: indexPath)
//            }
//        }
//    }
    //MARK: - UI Setup
    private func setupUI(){
        view.addSubviews(imageNavigationBar,labelNavigationBar,heartButtonNavigationBar,searchBar,homeCollectionView)
        
        imageNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        labelNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        heartButtonNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageNavigationBar.topAnchor.constraint(equalTo: view.topAnchor,constant: 55),
            imageNavigationBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 5),
            imageNavigationBar.widthAnchor.constraint(equalToConstant: 40),
            imageNavigationBar.heightAnchor.constraint(equalToConstant: 40),
            
            labelNavigationBar.topAnchor.constraint(equalTo: view.topAnchor,constant: 55),
            labelNavigationBar.leadingAnchor.constraint(equalTo: imageNavigationBar.trailingAnchor,constant: 10),
            labelNavigationBar.trailingAnchor.constraint(equalTo: heartButtonNavigationBar.leadingAnchor),
            labelNavigationBar.heightAnchor.constraint(equalToConstant: 40),
            
            heartButtonNavigationBar.topAnchor.constraint(equalTo: view.topAnchor,constant: 55),
            heartButtonNavigationBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -5),
            heartButtonNavigationBar.widthAnchor.constraint(equalToConstant: 32),
            heartButtonNavigationBar.heightAnchor.constraint(equalToConstant: 32),
            
            searchBar.topAnchor.constraint(equalTo: imageNavigationBar.bottomAnchor,constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            searchBar.widthAnchor.constraint(equalTo: homeCollectionView.widthAnchor,multiplier: 1.05),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            homeCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 5),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 5),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -5),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

