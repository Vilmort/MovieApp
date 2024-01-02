//
//  CollectionReusableView.swift
//  MovieApp
//
//  Created by Victor on 01.01.2024.
//

import UIKit

final class CollectionReusableView<View: Configurable>: UICollectionReusableView {
    private let view = View()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.update(with: nil)
    }
    
    func update(with model: View.Model) {
        view.update(with: model)
    }
    
    private func configure() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
