//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Victor Rubenko on 30.12.2023.
//

import UIKit
import SnapKit

private typealias TextCell = CollectionCell<UILabel>
private typealias MovieInfoCell = CollectionCell<MovieInfoView>

final class MovieDetailController: ViewController, MovieDetailControllerProtocol {
    
    var presenter: MovieDetailPresenterProtocol!
    
    private var sections = [Section]()
    private var model: Model = .default()
    private var posterSizeConstraint: Constraint?
    
    private let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: Constants.collectionTopOffset, left: .zero, bottom: .zero, right: .zero)
        cv.register(MovieInfoCell.self, forCellWithReuseIdentifier: String(describing: MovieInfoCell.self))
        cv.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter.activate()
    }
    
    func update(with model: Model) {
        self.model = model
        
        title = model.name
        posterImage.kf.setImage(with: model.poster)
        sections = [.movieInfo]
        collectionView.reloadData()
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(posterImage)
        posterImage.snp.makeConstraints {
            posterSizeConstraint = $0.size.equalTo(CGSize(width: Constants.posterWidth, height: Constants.posterHeight)).constraint
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
    }
}

extension MovieDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .cast:
            return model.cast?.count ?? 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .movieInfo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieInfoCell.self), for: indexPath) as! MovieInfoCell
            cell.update(
                with: .init(
                    year: model.year,
                    lenght: model.length,
                    genre: model.genre,
                    rating: model.rating ?? 0
                )
            )
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            cell.update(with: .init(text: "123 123 123", font: .MontserratBold(ofSize: 15), textColor: .appGreen, numberOfLines: 1))
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = abs(scrollView.contentOffset.y)
        if yOffset > Constants.collectionTopOffset {
            let k = yOffset / Constants.collectionTopOffset
            posterImage.snp.updateConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
                $0.size.equalTo(CGSize(width: Constants.posterWidth * k, height: Constants.posterHeight * k))
            }
        } else {
            posterImage.snp.updateConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(24 + yOffset - Constants.collectionTopOffset)
            }
        }
    }
}

extension MovieDetailController {
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        .init {
            sectionIndex, _ in
            
            var item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            var group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            
            switch self.sections[sectionIndex] {
            case .movieInfo, .actions, .plot:
                break
            case .cast:
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(1), heightDimension: .estimated(1)))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(1), heightDimension: .estimated(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

extension MovieDetailController {
    struct Model {
        
        struct CastMember {
            let imageURL: URL?
            let name: String?
            let role: String?
        }
        
        let poster: URL?
        let name: String
        let year: Int?
        let length: Int?
        let genre: String?
        let rating: Double?
        let plot: String?
        let cast: [CastMember]?
        let trailerAction: (() -> Void)?
        let shareAction: (() -> Void)?
        
        static func `default`() -> Self {
            .init(poster: nil, name: "", year: nil, length: nil, genre: nil, rating: nil, plot: nil, cast: nil, trailerAction: nil, shareAction: nil)
        }
    }
    
    enum Section {
        case movieInfo
        case actions
        case plot
        case cast
    }
}

private enum Constants {
    static var posterWidth: CGFloat {
        UIScreen.main.bounds.width * 0.55
    }
    static var posterHeight: CGFloat {
        posterWidth * 1.4
    }
    static var collectionTopOffset: CGFloat {
        posterHeight + 24 + 16
    }
}
