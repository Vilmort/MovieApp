//
//  PrivacyPresenter.swift
//  MovieApp
//
//  Created by Vanopr on 03.01.2024.
//

import Foundation

protocol PrivacyViewProtocol: AnyObject {
}

protocol PrivacyPresenterProtocol: AnyObject {
}

final class PrivacyPresenter: PrivacyPresenterProtocol {
    weak var view: PrivacyViewProtocol?
    init(view: PrivacyViewProtocol) {
        self.view = view
    }
}
