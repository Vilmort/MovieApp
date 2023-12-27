//
//  ViewController.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    let loadingView = LoadingView()
    let errorView = ErrorView()
}

extension ViewController: LoadingPresenting {
    func showLoading() {
        loadingView.animation.play()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingView.backgroundColor = view.backgroundColor
    }
    
    func hideLoading() {
        loadingView.animation.stop()
        loadingView.removeFromSuperview()
    }
}

extension ViewController: ErrorPresenting {
    func showError(
        _ title: String,
        message: String?,
        actionTitle: String?,
        action: ((UIView) -> Void)?
    ) {
        errorView.title = title
        errorView.message = message
        errorView.actionTitle = actionTitle
        errorView.action = action
        
        view.addSubview(errorView)
        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        errorView.animation.play()
    }
}
