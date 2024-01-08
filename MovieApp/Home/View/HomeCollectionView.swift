//
//  HomeCollectionView.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//


import UIKit

protocol HomeViewProtocol2: UIView {
    var collectionView: UICollectionView { get }
}

final class HomeCollectionView: UIView, HomeViewProtocol2 {
    
    //MARK: - Public properties
    let collectionView: UICollectionView = makeCollection()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appDark
        addSubviews(
            collectionView
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
}

private extension HomeCollectionView {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case categories
        case genres
        case mostPopular
    }
    
    //MARK: - Private methods

    static func makeCollection() -> UICollectionView {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionViewLayout()
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .appDark
        return collection
    }
    
    static func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .categories:
                return makeCategoriesLayoutSection()
                
            case .genres:
                return makeGenresButtonLayoutSection()
                
            case .mostPopular:
                return makeMostPopularLayoutSection()
                
            case nil:
                return nil
            }
        }
    }
    
    static func makeCategoriesLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(175)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    static func makeGenresButtonLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.6)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    static func makeMostPopularLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .absolute(231)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

