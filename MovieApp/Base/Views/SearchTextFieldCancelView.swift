//
//  SearchTextFieldCancelView.swift
//  MovieApp
//
//  Created by Victor on 11.01.2024.
//

import UIKit

final class SearchTextFieldCancelView: CustomView {
    var searchField = SearchTextField()
    private let cancelButton = UIButton(type: .system)
    
    var cancelAction: (() -> Void)?
    
    override func configure() {
        addSubview(searchField)
        
        searchField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        searchField.delegate = self
        
        cancelButton.setContentHuggingPriority(.required, for: .horizontal)
        cancelButton.tintColor = .white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    @objc
    private func didTapCancel() {
        searchField.text = nil
        searchField.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.setNeedsLayout()
                self.layoutIfNeeded()
                self.cancelButton.alpha = 0
            },
            completion: {
                _ in
                
                self.cancelButton.removeFromSuperview()
            }
        )
        searchField.resignFirstResponder()
        cancelAction?()
    }
}

extension SearchTextFieldCancelView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        addSubview(cancelButton)
        searchField.snp.remakeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-8)
        }
        cancelButton.snp.remakeConstraints {
            $0.centerY.equalTo(searchField)
            $0.trailing.equalToSuperview()
        }
        cancelButton.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.setNeedsLayout()
                self.layoutIfNeeded()
                self.cancelButton.alpha = 1
            }
        )
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        return true
    }
}
