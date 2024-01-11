//
//  HomeBuilder.swift
//  MovieApp
//
//  Created by Victor on 10.01.2024.
//

import UIKit

private typealias TextButtonHeader = CollectionReusableView<LabelButtonView>
private typealias SpaceCell = CollectionCell<SpaceView>
private typealias CategoryCell = CollectionCell<HomeCategoryView>
private typealias GenresCell = CollectionCell<HorizontalPicker>
private typealias MovieCell = CollectionCell<HomeMovieView>

final class HomeBuilder: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private let collection: UICollectionView
    private var sections = [Section]()
    private var popularIndex: Int?
    private var wasInitialized = false
    
    init(_ collection: UICollectionView) {
        self.collection = collection
        
        collection.register(SpaceCell.self, forCellWithReuseIdentifier: String(describing: SpaceCell.self))
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        collection.register(GenresCell.self, forCellWithReuseIdentifier: String(describing: GenresCell.self))
        collection.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
        collection.register(TextButtonHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TextButtonHeader.self))
    }
    
    func reloadData(_ model: HomeController.Model, _ onlyPopular: Bool) {
        if !wasInitialized {
            collection.dataSource = self
            collection.delegate = self
            collection.collectionViewLayout = makeLayout()
            wasInitialized = true
        }
        
        if onlyPopular, let popularIndex {
            sections[popularIndex] = .popularMovies(
                model: model.popularMovies!,
                header: .init(
                    title: "Popular movies",
                    seeAll: model.popularMovies?.seeAllHandler
                )
            )
            collection.reloadSections(IndexSet([popularIndex]))
        } else {
            sections = []
            if model.categories != nil {
                sections += [
                    .categories(
                        model: model.categories!,
                        header: .init(
                            title: "Categories",
                            seeAll: {
                                model.categories?.seeAllHandler()
                            }
                        )
                    )
                ]
            }
            if model.genres != nil {
                sections += [
                    .genres(
                        model: model.genres!,
                        header: .init(
                            title: "Genres",
                            seeAll: nil
                        )
                    )
                ]
            }
            popularIndex = sections.count
            if model.popularMovies != nil {
                sections += [
                    .popularMovies(
                        model: model.popularMovies!,
                        header: .init(
                            title: "Popular movies",
                            seeAll: model.popularMovies?.seeAllHandler
                        )
                    )
                ]
            }
            collection.reloadData()
        }
    }
    
    func reloadPopularMovies(_ model: HomeController.Model.PopularMovies) {
        sections[2] = .popularMovies(
            model: model,
            header: .init(
                title: "Popular movies",
                seeAll: model.seeAllHandler
            )
        )
        collection.reloadData()
    }
    
    func makeLayout() -> UICollectionViewCompositionalLayout {
        .init {
            sectionIndex, _ in
            
            var item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            var group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            var section = NSCollectionLayoutSection(group: group)
            
            switch self.sections[sectionIndex] {
            case .space:
                break
            case .popularMovies:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(135), heightDimension: .absolute(231)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(135), heightDimension: .absolute(231)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                section.interGroupSpacing = 12
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                section.orthogonalScrollingBehavior = .continuous
            case .genres:
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            case .categories:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.78), heightDimension: .fractionalWidth(0.41)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 12
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            }
            return section
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .categories(let model, header: _):
            return model.categories.count
        case .popularMovies(let model, header: _):
            return model.movies.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: SectionHeader?
        var insets: UIEdgeInsets = .zero
        switch sections[indexPath.section] {
        case let .categories(model: _, header: sectionHeader):
            header = sectionHeader
            insets = .init(top: 16, left: 16, bottom: 16, right: 16)
        case let .genres(model: _, header: sectionHeader):
            header = sectionHeader
            insets = .init(top: 16, left: 16, bottom: 16, right: 16)
        case let .popularMovies(model: _, header: sectionHeader):
            header = sectionHeader
            insets = .init(top: 16, left: 0, bottom: 16, right: 0)
        default:
            break
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TextButtonHeader.self), for: indexPath) as! TextButtonHeader
        view.update(with: .init(text: .init(text: header?.title ?? "", font: .montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1), buttonTitle: "See All", buttonHandler: header?.seeAll), insets: insets)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .categories(model: let model, header: _):
            let category = model.categories[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
            cell.update(with: .init(imageURL: category.imageURL, title: category.title, info: category.count), didSelectHandler: category.didSelectHandler)
            return cell
        case .genres(model: let model, header: _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenresCell.self), for: indexPath) as! GenresCell
            cell.update(with: .init(items: model.genres.map { .init(title: $0.title, didSelectHandler: $0.didSelectHandler) }, preselectedIndex: model.preselectedIndex))
            return cell
        case .popularMovies(model: let model, header: _):
            let movie = model.movies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
            cell.update(
                with: .init(
                    image: .init(image: nil, url: movie.imageURL, tintColor: nil, contenMode: .scaleAspectFill, size: CGSize(width: 135, height: 178)),
                    name: .init(text: movie.title, font: .montserratSemiBold(ofSize: 14), textColor: .white, numberOfLines: 1),
                    genre: .init(text: movie.genre ?? "", font: .montserratMedium(ofSize: 10), textColor: .appTextGrey, numberOfLines: 1)
                ),
                didSelectHandler: movie.didSelect
            )
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            return cell
        case let .space(height):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpaceCell.self), for: indexPath) as! SpaceCell
            cell.update(with: .init(height: height))
            return cell
        }
    }
}

extension HomeBuilder {
    struct SectionHeader {
        let title: String
        let seeAll: (() -> Void)?
    }
    enum Section {
        case space(CGFloat)
        case categories(model: HomeController.Model.Categories, header: SectionHeader)
        case genres(model: HomeController.Model.Genres, header: SectionHeader)
        case popularMovies(model: HomeController.Model.PopularMovies, header: SectionHeader)
    }
}
