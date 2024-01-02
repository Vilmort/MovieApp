//
//  CollectionView.swift
//  MovieApp
//
//  Created by Victor on 27.12.2023.
//

import UIKit

class CollectionCell<View: Configurable>: UICollectionViewCell {
    private let view = View()
    private let stackView = UIStackView()
    private var didSelectHandler: (() -> Void)?
    
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
        subviews.first { $0 is SpoilerView }?.removeFromSuperview()
        backgroundColor = .clear
    }
    
    func update(
        with model: View.Model,
        height: CGFloat? = nil,
        insets: UIEdgeInsets = .zero,
        didSelectHandler: (() -> Void)? = nil
    ) {
        view.update(with: model)
        self.didSelectHandler = didSelectHandler
        
        if let height {
            stackView.snp.remakeConstraints {
                $0.height.equalTo(height)
                $0.edges.equalToSuperview().inset(insets)
            }
        } else {
            stackView.snp.updateConstraints {
                $0.edges.equalToSuperview().inset(insets)
            }
        }
    }
    
    private func configure() {
        
        backgroundColor = .clear
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tapGR.cancelsTouchesInView = false
        addGestureRecognizer(tapGR)
    }
    
    @objc
    private func didSelect() {
        didSelectHandler?()
    }
}
