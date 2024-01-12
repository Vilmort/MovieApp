//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Vanopr on 25.12.2023.
//

import UIKit

final class ProfileViewController: ViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol!
    private let userView = UserView()
    
    private var generalView = GeneralView(
        frame: .zero, title: "General".localized,
        firstTitle: "Notifications".localized,
        firstImage: .notification,
        secondTitle: "Language".localized,
        secondImage: .globe
    )
    
    private var moreView = GeneralView(
        frame: .zero, title: "More".localized,
        firstTitle: "Legal and Policies".localized,
        firstImage: .shield,
        secondTitle: "About Us".localized,
        secondImage: .alert
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupView() {
        view.addSubviews(userView, generalView, moreView)
        setupConstraints()
        view.backgroundColor = .appDark
    }
    
    // MARK: - Private Methods
    private func setupEditButton() {
        userView.editButtonTap = {
            self.presenter.showEditProfileVC()
        }
    }
    
    private func setupNotificationButton() {
        generalView.onFirstTap = {
            self.presenter.showNotificationVC()
        }
    }
    
    private func setupPoliciesButton() {
        moreView.onFirstTap = {
            self.presenter.showPolicyVC()
        }
    }
    
    private func setupAboutUsButton() {
        moreView.onSecondTap = {
            self.presenter.showAboutUsVC()
        }
    }
    
    private func setupLanguageViewButton() {
        generalView.onSecondTap = {
            self.presenter.showLanguageVC()
        }
    }
    
    private func setupButtons() {
        setupPoliciesButton()
        setupEditButton()
        setupNotificationButton()
        setupPoliciesButton()
        setupAboutUsButton()
        setupLanguageViewButton()
    }
    
    private func updateUI() {
        guard let user = presenter.fetchUser() else { return }
        userView.setViews(with: user)
    }
     
    func setupConstraints() {
        userView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(80)
        }
        
        generalView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(210)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(210)
        }
    }
    
    
}
