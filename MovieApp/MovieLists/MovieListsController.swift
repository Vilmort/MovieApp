//
//  MovieListsController.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit

private typealias SpaceCell = TableCell<SpaceView>
private typealias ListCell = TableCell<MovieListView>

final class MovieListsController: ViewController, MovieListsViewProtocol {
    var presenter: MovieListsPresenter!
    
    private var items = [Item]()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.backgroundColor = .clear
        tv.register(SpaceCell.self, forCellReuseIdentifier: String(describing: SpaceCell.self))
        tv.register(ListCell.self, forCellReuseIdentifier: String(describing: ListCell.self))
        return tv
    }()
    
    private let listPicker = HorizontalPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Lists"
        configure()
        presenter.activate()
    }
    
    func update(with model: Model) {
        items = model.lists.enumerated().map {
            index, list in
            
            if index == model.lists.count - 1 {
                return [Item.list(list)]
            }
            return [Item.list(list), Item.space(24)]
        }.flatMap { $0 }
        tableView.reloadData()
        
        if model.updateCategories {
            listPicker.update(
                with: .init(
                    items: model.categories
                )
            )
        }
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubview(listPicker)
        listPicker.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(tableView)
        let header = UIView()
        tableView.tableHeaderView = header
        tableView.snp.makeConstraints {
            $0.top.equalTo(listPicker.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

extension MovieListsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case let .list(listModel):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ListCell.self),
                for: indexPath
            ) as! ListCell
            cell.update(with: listModel.list, height: 150, didSelectHandler: listModel.didSelect)
            cell.selectionStyle = .none
            return cell
        case let .space(height):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: SpaceCell.self),
                for: indexPath
            ) as! SpaceCell
            cell.update(with: .init(height: height))
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension MovieListsController {
    struct Model {
        struct MovieList {
            let list: MovieListView.Model
            let didSelect: () -> Void
        }
        
        let categories: [HorizontalPicker.Model.Item]
        let lists: [MovieList]
        let updateCategories: Bool
    }
    
    private enum Item {
        case list(Model.MovieList)
        case space(CGFloat)
    }
}
