//
//  MovieListPicker.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

final class MovieListPickerCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .clear
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.width.greaterThanOrEqualTo(66)
        }
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}

final class MovieListPicker: CustomView {
    private lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = .clear
        cv.register(MovieListPickerCell.self, forCellWithReuseIdentifier: String(describing: MovieListPickerCell.self))
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private var items = [Model.Item]()
    private var selectedIndex = 0
    
    override func configure() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(31)
            $0.top.bottom.equalToSuperview().inset(4)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        .init {
            _, _ in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(44), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(44), heightDimension: .absolute(31)), subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: .zero, leading: 16, bottom: .zero, trailing: 16)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
}

extension MovieListPicker: Configurable {
    struct Model {
        
        struct Item {
            let title: String
            let didSelectHandler: (() -> Void)?
        }
        
        let items: [Item]
    }
    
    func update(with model: Model) {
        self.items = model.items
        collectionView.reloadData()
    }
}

extension MovieListPicker: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieListPickerCell.self), for: indexPath) as! MovieListPickerCell
        cell.layer.cornerRadius = 8
        cell.backgroundColor = indexPath.row == selectedIndex ? .appSoft : .clear
        cell.label.update(
            with: .init(
                text: item.title,
                font: .montserratMedium(ofSize: 12),
                textColor: indexPath.row == selectedIndex ? .appBlue : .white,
                numberOfLines: 1,
                alignment: .center
            )
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        collectionView.visibleCells.compactMap { $0 as? MovieListPickerCell }.forEach {
            $0.backgroundColor = .clear
            $0.label.textColor = .white
        }
        let cell = collectionView.cellForItem(at: indexPath) as! MovieListPickerCell
        cell.backgroundColor = .appSoft
        cell.label.textColor = .appBlue
        
        let item = items[indexPath.row]
        item.didSelectHandler?()
    }
}
