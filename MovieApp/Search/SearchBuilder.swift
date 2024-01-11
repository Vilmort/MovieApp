//
//  SearchBuilder.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

private typealias TextButtonHeader = CollectionReusableView<LabelButtonView>
private typealias MovieCell = CollectionCell<MovieView>
private typealias ArtistCell = CollectionCell<ImageTitleSubtitleView>

final class SearchBuilder {
    
    typealias Model = SearchController.Model
    
    private let collection: UICollectionView
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    private var didSelectMovie: ((Int) -> Void)?
    
    init(_ collection: UICollectionView) {
        self.collection = collection
        
        collection.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
        collection.register(ArtistCell.self, forCellWithReuseIdentifier: String(describing: ArtistCell.self))
        collection.register(TextButtonHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TextButtonHeader.self))
        
        configureDataSource()
        collection.collectionViewLayout = makeLayout()
    }
    
    func reloadData(_ model: Model) {
        didSelectMovie = model.didSelectMovie
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        if !model.artists.isEmpty {
            snapshot.appendSections([.artists])
            snapshot.appendItems(model.artists.map { .artist($0) }, toSection: .artists)
        }
        if !model.movies.isEmpty {
            snapshot.appendSections([.movies])
            snapshot.appendItems(model.movies.map { .movie($0) }, toSection: .movies)
        }
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        dataSource = .init(
            collectionView: collection,
            cellProvider: {
                [weak self] collectionView, indexPath, itemIdentifier in
                
                switch itemIdentifier {
                case let .movie(movie):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: MovieCell.self),
                        for: indexPath
                    ) as! MovieCell
                    cell.update(
                        with: movie.model,
                        didSelectHandler: {
                            self?.didSelectMovie?(movie.id)
                        }
                    )
                    return cell
                case .artist(let artist):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: ArtistCell.self),
                        for: indexPath
                    ) as! ArtistCell
                    
                    cell.update(
                        with: .init(
                            image: .init(image: nil, url: artist.imageURL, tintColor: nil, size: CGSize(width: 64, height: 64), cornerRadius: 32),
                            title: .init(text: self?.makeArtistNameString(artist.name) ?? NSAttributedString(), numberOfLines: 2, textAlignment: .center),
                            spacing: 8,
                            axis: .vertical
                        )
                    )
                    return cell
                }
            }
        )
        dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            
            switch self.snapshot.sectionIdentifiers[indexPath.section] {
            case .artists:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TextButtonHeader.self), for: indexPath) as! TextButtonHeader
                view.update(with: .init(text: .init(text: "Artists", font: .montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1), buttonTitle: "", buttonHandler: nil), insets: .init(top: 16, left: 24, bottom: 16, right: 24))
                return view
            case .movies:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TextButtonHeader.self), for: indexPath) as! TextButtonHeader
                view.update(with: .init(text: .init(text: "Movies", font: .montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1), buttonTitle: "", buttonHandler: nil))
                return view
            }
        }
        
        collection.dataSource = dataSource
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        .init {
            [weak self] sectionIndex, _ in
            
            guard let self else {
                return nil
            }
            
            switch self.snapshot.sectionIdentifiers[sectionIndex] {
            case .artists:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(82), heightDimension: .absolute(110)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(82), heightDimension: .absolute(110)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 12
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
            case .movies:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.contentInsets = .init(top: .zero, leading: 24, bottom: 16, trailing: 24)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
            }
        }
    }
    
    private func makeArtistNameString(_ name: String) -> NSAttributedString {
        let parts = name.components(separatedBy: " ")
        let fName = parts.first ?? ""
        let sName = parts.suffix(from: 1)
        
        let string = NSMutableAttributedString(
            string: fName,
            attributes: [.font: UIFont.montserratSemiBold(ofSize: 12), .foregroundColor: UIColor.white]
        )
        
        guard !sName.isEmpty else {
            return string
        }
        string.append(
            NSAttributedString(
                string: " " + sName.joined(separator: " "),
                attributes: [.font: UIFont.montserratSemiBold(ofSize: 12), .foregroundColor: UIColor.appTextGrey]
            )
        )
        return string
    }
    
}

extension SearchBuilder {
    enum Section: Hashable {
        case artists
        case movies
    }
    
    enum Item: Hashable {
        case movie(Model.Movie)
        case artist(Model.Artist)
    }
}
