//
//  SearchController.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

private typealias SpaceCell = TableCell<SpaceView>
private typealias MovieCell = TableCell<MovieView>

final class SearchController: ViewController, SearchViewProtocol {
    
    var presenter: SearchPresenterProtocol!
    
    private let searchTextField = SearchTextFieldCancelView()
    private let emptyView = ImageTitleSubtitleView()
    
    private lazy var builder = SearchBuilder(collectionView)
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.keyboardDismissMode = .onDrag
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.activate()
    }
    
    func update(with model: Model) {
        
        if model.emptyQuery {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = !model.movies.isEmpty || !model.artists.isEmpty
        }
        
        emptyView.update(
            with: .init(
                image: .init(image: .noResults, renderingMode: .alwaysOriginal, tintColor: nil),
                title: .init(
                    text: model.emptyQuery ? "Enter movie title to start searching".localized : "We couldn't find movies matching your request".localized,
                    font: .montserratSemiBold(ofSize: 16),
                    textColor: .white,
                    numberOfLines: 0,
                    alignment: .center
                ),
                subtitle: .init(text: "", font: .montserratMedium(ofSize: 12), textColor: .white, numberOfLines: 0, alignment: .center),
                spacing: 16,
                axis: .vertical
            )
        )
        
        builder.reloadData(model)
    }
    
    func showKeyboard() {
        searchTextField.searchField.becomeFirstResponder()
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        navigationItem.titleView = searchTextField
        searchTextField.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 48)
            $0.height.equalTo(41)
        }
        searchTextField.layer.cornerRadius = 16
        searchTextField.layer.masksToBounds = true
        searchTextField.searchField.changeTextHandler = {
            [weak presenter] text in
            
            presenter?.didEnterQuery(text)
        }
        searchTextField.cancelAction = {
            [weak presenter] in
            
            presenter?.didEnterQuery(nil)
        }
        
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.contentInset = .init(top: 8, left: .zero, bottom: .zero, right: .zero)
        
        let tapGR = UITapGestureRecognizer()
        tapGR.cancelsTouchesInView = false
        tapGR.addTarget(self, action: #selector(didTap))
        view.addGestureRecognizer(tapGR)
        
    }
    
    @objc
    private func didTap() {
        searchTextField.searchField.resignFirstResponder()
    }
}

extension SearchController {
    struct Model {
        
        struct Movie: Hashable {
            let id: Int
            let model: MovieView.Model
        }
        
        struct Artist: Hashable {
            let id: Int
            let name: String
            let imageURL: URL?
        }
        
        let movies: [Movie]
        let artists: [Artist]
        let emptyQuery: Bool
        
        let didSelectMovie: ((Int) -> Void)?
        let didSelectArtist: ((Int) -> Void)?
    }
}
