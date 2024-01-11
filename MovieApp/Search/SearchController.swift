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
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.backgroundColor = .clear
        tv.register(SpaceCell.self, forCellReuseIdentifier: String(describing: SpaceCell.self))
        tv.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tv.keyboardDismissMode = .onDrag
        return tv
    }()
    private var items = [Item]()
    
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
            emptyView.isHidden = !model.movies.isEmpty
        }
        
        emptyView.update(
            with: .init(
                image: .init(image: .noResults, renderingMode: .alwaysOriginal, tintColor: nil),
                title: .init(
                    text: model.emptyQuery ? "Введите название фильма, чтобы начать поиск" : "Не удалось найти фильмы по вашему запросу",
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
        
        items = []
        model.movies.forEach {
            items += [
                .movie($0),
                .space(16)
            ]
        }
        tableView.reloadData()
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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        tableView.contentInset = .init(top: 32, left: .zero, bottom: .zero, right: .zero)
        
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

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .movie(let movie):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
            cell.update(with: movie.model, didSelectHandler: movie.didSelect)
            cell.selectionStyle = .none
            return cell
        case .space(let height):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpaceCell.self), for: indexPath) as! SpaceCell
            cell.update(with: .init(height: height))
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
}

extension SearchController {
    struct Model {
        struct Movie {
            let model: MovieView.Model
            let didSelect: () -> Void
        }
        let movies: [Movie]
        let emptyQuery: Bool
    }
    
    enum Item {
        case space(CGFloat)
        case movie(Model.Movie)
    }
}
