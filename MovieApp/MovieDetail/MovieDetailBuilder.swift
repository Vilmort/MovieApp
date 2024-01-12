//
//  MovieDetailCollectionBuilder.swift
//  MovieApp
//
//  Created by Victor on 02.01.2024.
//

import UIKit

private typealias TextCell = CollectionCell<UILabel>
private typealias MovieInfoCell = CollectionCell<MovieInfoView>
private typealias SpaceCell = CollectionCell<SpaceView>
private typealias CastCell = CollectionCell<ImageTitleSubtitleView>
private typealias ImageCell = CollectionCell<UIImageView>
private typealias TextHeader = CollectionReusableView<UILabel>
private typealias YouTubeCell = CollectionCell<YouTubeView>
private typealias MovieActionsCell = CollectionCell<MovieActionsView>

final class MovieDetailCollectionBuilder: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var sections = [MovieDetailController.Section]()
    private var cast = [(model: ImageTitleSubtitleView.Model, didSelectHandler: (() -> Void)?)]()
    private var images = [UIImageView.Model]()
    private var facts = [(model: UILabel.Model, spoiler: Bool)]()
    private var videos = [String]()
    private var similarMovies = [(model: ImageTitleSubtitleView.Model, didSelectHandler: (() -> Void)?)]()
    
    private let collection: UICollectionView
    private var model: MovieDetailController.Model?
    
    var scrollViewDidScroll: ((UIScrollView) -> Void)?
    
    init(_ collection: UICollectionView) {
        self.collection = collection
        
        collection.register(MovieInfoCell.self, forCellWithReuseIdentifier: String(describing: MovieInfoCell.self))
        collection.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        collection.register(SpaceCell.self, forCellWithReuseIdentifier: String(describing: SpaceCell.self))
        collection.register(CastCell.self, forCellWithReuseIdentifier: String(describing: CastCell.self))
        collection.register(ImageCell.self, forCellWithReuseIdentifier: String(describing: ImageCell.self))
        collection.register(YouTubeCell.self, forCellWithReuseIdentifier: String(describing: YouTubeCell.self))
        collection.register(MovieActionsCell.self, forCellWithReuseIdentifier: String(describing: MovieActionsCell.self))
        collection.register(TextHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TextHeader.self))
    }
    
    func reloadData(_ model: MovieDetailController.Model) {
        self.model = model
        sections = [
            .text(text: model.name, font: .MontserratBold(ofSize: 25)),
            .space(8),
            .movieInfo(.init(country: model.country, year: model.year, lenght: model.length, genre: model.genre, rating: model.rating, age: model.age)),
            .space(16),
        ]
        if model.watchAction != nil {
            sections += [.actions, .space(16)]
        }
        if let plot = model.plot {
            sections += [.text(text: plot, font: .montserratMedium(ofSize: 14)), .space(16)]
        }
        if let cast = model.cast {
            self.cast = cast.map {
                (
                    model: .init(
                    image: .init(image: nil, url: $0.imageURL, renderingMode: .alwaysOriginal, tintColor: nil, size: .init(width: 40, height: 60), cornerRadius: 10),
                    title: .init(text: $0.name ?? "", font: .montserratRegular(ofSize: 12), textColor: .white, numberOfLines: 1),
                    subtitle: .init(text: $0.role ?? "", font: .montserratRegular(ofSize: 12), textColor: .white, numberOfLines: 1),
                    spacing: 4
                ),
                    didSelectHandler: $0.didSelectHandler
                    )
            }
            sections += [.cast(header: "Crew".localized), .space(16)]
        }
        if !model.images.isEmpty {
            self.images = model.images.map { .init(image: nil, url: $0, tintColor: nil, size: .init(width: 150, height: 100)) }
            sections += [.images(header: "Personnel".localized), .space(16)]
        }
        if !model.videos.isEmpty {
            self.videos = model.videos
            sections += [.videos(header: "Video".localized), .space(16)]
        }
        if !model.facts.isEmpty {
            self.facts = model.facts.map {
                (
                    model: .init(
                        text: $0.text,
                        font: .montserratRegular(ofSize: 13),
                        textColor: .white,
                        numberOfLines: 0,
                        alignment: .center
                    ),
                    spoiler: $0.spoiler
                )
            }
            sections += [.facts(header: "Interesting Facts".localized), .space(16)]
        }
        if !model.similarMovies.isEmpty {
            similarMovies = model.similarMovies.map {
                (
                    model: .init(
                        image: .init(image: nil, url: $0.imageURL, tintColor: nil, size: .init(width: 100, height: 150)),
                        title: .init(text: $0.name, font: .montserratMedium(ofSize: 12), textColor: .white, numberOfLines: 2),
                        spacing: 4,
                        axis: .vertical
                    ),
                    didSelectHandler: $0.didSelectHandler
                )
            }
            sections += [.similarMovies(header: "Similar Movies".localized), .space(16)]
        }
        collection.dataSource = self
        collection.delegate = self
        collection.collectionViewLayout = makeLayout()
        collection.reloadData()
    }
    
    func makeLayout() -> UICollectionViewCompositionalLayout {
        .init {
            sectionIndex, _ in
            
            var item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            var group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            var section = NSCollectionLayoutSection(group: group)
            
            switch self.sections[sectionIndex] {
            case .movieInfo, .actions, .space, .text:
                break
            case .cast:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .estimated(1)))
                let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .estimated(1)), subitems: [item, item])
                vGroup.interItemSpacing = .fixed(4)
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(1), heightDimension: .estimated(1)), subitems: [vGroup])
                group.interItemSpacing = .fixed(8)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: .zero, leading: 16, bottom: .zero, trailing: 16)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            case .images:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(1), heightDimension: .estimated(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(1), heightDimension: .estimated(1)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 8
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            case .facts:
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(1)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            case .videos:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalWidth(0.45)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            case .similarMovies:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .estimated(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .estimated(1)), subitems: [item])
                group.interItemSpacing = .fixed(8)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            }
            section.contentInsets = .init(top: .zero, leading: 16, bottom: .zero, trailing: 16)
            return section
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .cast:
            return cast.count
        case .facts:
            return facts.count
        case .videos:
            return videos.count
        case .similarMovies:
            return similarMovies.count
        case .images:
            return images.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: String?
        switch sections[indexPath.section] {
        case let .cast(header: sectionHeader):
            header = sectionHeader
        case let .facts(header: sectionHeader):
            header = sectionHeader
        case let .videos(header: sectionHeader):
            header = sectionHeader
        case let .similarMovies(header: sectionHeader):
            header = sectionHeader
        case let .images(header: sectionHeader):
            header = sectionHeader
        default:
            break
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TextHeader.self), for: indexPath) as! TextHeader
        view.update(
            with: .init(
                text: header ?? "",
                font: .MontserratBold(ofSize: 14),
                textColor: .appBlue,
                numberOfLines: 1
            )
        )
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case let .movieInfo(model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieInfoCell.self), for: indexPath) as! MovieInfoCell
            cell.update(with: model)
            return cell
        case let .text(text: text, font: font):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            cell.update(
                with: .init(
                    text: text,
                    font: font,
                    textColor: .white,
                    numberOfLines: 0,
                    alignment: .center
                )
            )
            return cell
        case let .space(height):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpaceCell.self), for: indexPath) as! SpaceCell
            cell.update(with: .init(height: height))
            return cell
        case .cast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCell.self), for: indexPath) as! CastCell
            let artist = cast[indexPath.row]
            cell.update(with: artist.model, didSelectHandler: artist.didSelectHandler)
            return cell
        case .images:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as! ImageCell
            cell.update(with: images[indexPath.row])
            return cell
        case .facts:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            cell.update(with: facts[indexPath.row].model, insets: .init(top: 8, left: 16, bottom: 8, right: 16))
            if facts[indexPath.row].spoiler {
                cell.markAsSpoiler()
            }
            cell.backgroundColor = .appSoft
            return cell
        case .videos:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: YouTubeCell.self), for: indexPath) as! YouTubeCell
            cell.update(with: .init(link: videos[indexPath.row]))
            return cell
        case .similarMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCell.self), for: indexPath) as! CastCell
            let similarMovie = similarMovies[indexPath.row]
            cell.update(with: similarMovie.model, didSelectHandler: similarMovie.didSelectHandler)
            return cell
        case .actions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieActionsCell.self), for: indexPath) as! MovieActionsCell
            cell.update(with: .init(watchClosure: model?.watchAction, shareClosure: model?.shareAction))
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScroll?(scrollView)
    }
}
