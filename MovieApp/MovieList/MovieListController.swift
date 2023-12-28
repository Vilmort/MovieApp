//
//  MovieListController.swift
//  MovieApp
//
//  Created by Victor on 28.12.2023.
//

import UIKit

private typealias SpaceCell = TableCell<SpaceView>
private typealias MovieCell = TableCell<MovieView>

final class MovieListController: ViewController, MovieListControllerProtocol {
    
    var presenter: MovieListPresenterProtocol!
    
    private var items = [Item]()
    
    private let horizontalPicker = HorizontalPicker()
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
        return tv
    }()
    private var emptyImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .folder
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter.activate()
    }
    
    func update(with model: Model) {
        items = model.movies.enumerated().map {
            index, movie in
            
            if index == model.movies.count - 1 {
                return [Item.movie(movie)]
            }
            return [Item.movie(movie), Item.space(16)]
        }.flatMap { $0 }
        tableView.reloadData()
        
        emptyImage.isHidden = !items.isEmpty
        
        if model.updateGenres {
            horizontalPicker.update(with: .init(items: model.genres))
        }
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubviews(tableView, horizontalPicker, emptyImage)
        horizontalPicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(horizontalPicker.snp.bottom).offset(24)
        }
        
        emptyImage.snp.makeConstraints {
            $0.center.equalTo(tableView)
        }
        emptyImage.isHidden = true
    }
}

extension MovieListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case let .movie(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
            cell.update(with: model.model, didSelectHandler: model.didSelectHandler)
            cell.selectionStyle = .none
            return cell
        case let .space(height):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpaceCell.self), for: indexPath) as! SpaceCell
            cell.update(with: .init(height: height))
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension MovieListController {
    struct Model {
        struct Movie {
            let model: MovieView.Model
            let didSelectHandler: (() -> Void)
        }
        let movies: [Movie]
        let genres: [HorizontalPicker.Model.Item]
        let updateGenres: Bool
    }
    
    enum Item {
        case movie(Model.Movie)
        case space(CGFloat)
    }
}
