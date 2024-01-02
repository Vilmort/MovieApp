//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Victor on 30.12.2023.
//

import UIKit
import SnapKit

final class MovieDetailController: ViewController, MovieDetailControllerProtocol {
    
    var presenter: MovieDetailPresenterProtocol!
    
    private var posterSizeConstraint: Constraint?
    
    private let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.3
        return iv
    }()
    
    private lazy var backgroundGradient: GradientView = {
        let view = GradientView()
        view.update(
            with: .init(
                colors: [UIColor.clear, view.backgroundColor ?? UIColor.appDark],
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1),
                locations: nil
            )
        )
        return view
    }()
    private lazy var builder = MovieDetailCollectionBuilder(collectionView)
    
    private let titleLabel = UILabel()
    private var parentNavAppearance: UINavigationBarAppearance?
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.contentInset = .init(top: Constants.collectionTopOffset, left: .zero, bottom: .zero, right: .zero)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleLabel
        configure()
        presenter.activate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImage.isHidden = false
        parentNavAppearance = navigationController?.navigationBar.scrollEdgeAppearance
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        backgroundImage.isHidden = true
        guard let parentNavAppearance else {
            return
        }
        navigationController?.navigationBar.scrollEdgeAppearance = parentNavAppearance
    }
    
    func update(with model: Model) {
        titleLabel.update(with: .init(text: model.name, font: .montserratMedium(ofSize: 14), textColor: .white.withAlphaComponent(0), numberOfLines: 1))
        titleLabel.sizeToFit()
        posterImage.kf.setImage(with: model.poster)
        backgroundImage.kf.setImage(with: model.backgroundImage)
        
        builder.reloadData(model)
        collectionView.reloadData()
    }
    
    func showShare(_ url: URL) {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(vc, animated: true)
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.collectionTopOffset + (navigationController?.navigationBar.frame.height ?? 0) + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0))
        }
        view.addSubview(backgroundGradient)
        backgroundGradient.snp.makeConstraints {
            $0.edges.equalTo(backgroundImage)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(posterImage)
        posterImage.snp.makeConstraints {
            posterSizeConstraint = $0.size.equalTo(CGSize(width: Constants.posterWidth, height: Constants.posterHeight)).constraint
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        builder.scrollViewDidScroll = {
            [weak self] scrollView in
            
            guard let self else {
                return
            }
            
            let yOffset = scrollView.contentOffset.y * -1
            let safeArea = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) + (navigationController?.navigationBar.bounds.height ?? 0)
            let treshold = Constants.collectionTopOffset + safeArea - 5
            if yOffset > treshold {
                let k = yOffset / treshold
                posterImage.snp.updateConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
                    $0.size.equalTo(CGSize(width: Constants.posterWidth * k, height: Constants.posterHeight * k))
                }
            } else {
                posterImage.snp.updateConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24 + yOffset - treshold)
                }
            }
            if yOffset < 50 {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                let value = (yOffset - 50) * -1 / 50
                let alpha = value > 1 ? 1 : value
                appearance.backgroundColor = .appDark.withAlphaComponent(alpha)
                titleLabel.textColor = .white.withAlphaComponent(alpha)
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
            } else {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                titleLabel.textColor = .white.withAlphaComponent(.zero)
            }
            backgroundImage.alpha = [(yOffset - Constants.collectionTopOffset * 0.35) / treshold, 0.45].min()!
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
        
        struct Fact {
            let text: String
            let spoiler: Bool
        }
        
        struct SimilarMovie {
            let imageURL: URL?
            let name: String
            let didSelectHandler: (() -> Void)?
        }
        
        let poster: URL?
        let name: String
        let country: String?
        let year: Int?
        let length: Int?
        let genre: String?
        let rating: Double?
        let age: String?
        let plot: String?
        let cast: [CastMember]?
        let images: [URL]
        let facts: [Fact]
        let videos: [String]
        let similarMovies: [SimilarMovie]
        let watchAction: (() -> Void)?
        let shareAction: (() -> Void)?
        let backgroundImage: URL?
    }
    
    enum Section {
        case text(text: String, font: UIFont)
        case movieInfo(MovieInfoView.Model)
        case actions
        case cast(header: String?)
        case images(header: String?)
        case facts(header: String?)
        case videos(header: String?)
        case similarMovies(header: String?)
        case space(CGFloat)
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
    static var videoWidth: CGFloat {
        (UIScreen.main.bounds.width - 32) * 0.85
    }
    static var videoHeight: CGFloat {
        videoWidth * 0.56
    }
}
