//
//  WishlistController.swift
//  MovieApp
//
//  Created by Victor on 04.01.2024.
//

import UIKit

private typealias WishlistCell = TableCell<WishlistMovieView>

final class WishlistController: ViewController, WishlistControllerProtocol {
    
    var presenter: WishlistPresenterProtocol!
    
    private var items = [Model.Item]()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.backgroundColor = .clear
        tv.register(WishlistCell.self, forCellReuseIdentifier: String(describing: WishlistCell.self))
        return tv
    }()
    
    private let emptyView = ImageTitleSubtitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wishlist"
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.activate()
    }
    
    func update(with model: Model) {
        items = model.items
        emptyView.isHidden = !items.isEmpty
        tableView.isHidden = items.isEmpty
        tableView.reloadData()
    }
    
    func removeFromWishlist(_ index: Int) {
        tableView.beginUpdates()
        items.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
        if items.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.tableView.isHidden = true
                self.emptyView.isHidden = false
            }
        }
    }
    
    private func configure() {
        view.backgroundColor = .appDark
        
        view.addSubviews(tableView, emptyView)
        
        emptyView.update(
            with: .init(
                image: .init(image: .folder, renderingMode: .alwaysOriginal, tintColor: nil),
                title: .init(text: "There is no movie yet!", font: .montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 0, alignment: .center),
                spacing: 16,
                axis: .vertical
            )
        )
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WishlistController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WishlistCell.self), for: indexPath) as! WishlistCell
        cell.update(
            with: .init(
                imageURL: item.imageURL,
                name: item.name,
                genre: item.genre,
                movieType: item.movieType,
                rating: item.rating,
                wishlistHandler: item.wishlistHandler
            ),
            insets: .init(top: 8, left: 24, bottom: 8, right: 24),
            didSelectHandler: item.didSelectHandler
        )
        cell.selectionStyle = .none
        return cell
    }
}

extension WishlistController {
    struct Model {
        struct Item {
            let imageURL: URL?
            let name: String
            let genre: String?
            let movieType: String?
            let rating: Double?
            let wishlistHandler: () -> Void
            let didSelectHandler: (() -> Void)?
        }
        
        let items: [Item]
    }
}
