//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation


import UIKit

protocol LanguageVCProtocol: AnyObject {
}

final class LanguageViewController: ViewController, LanguageVCProtocol {
    
    // MARK: - Presenter
    var presenter: LanguagePresenterProtocol!
    
    // MARK: - Private UI Properties
    private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.appTextGrey.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .clear
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.whatLanguageSelected()
        setViews()
        title = "Language".localized
        setupConstraints()
        setupTableView()
        configureBarBackButton()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setViews() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .appDark
        view.addSubview(mainView)
        mainView.addSubview(tableView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstraint.mainViewTopOffset)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutConstraint.mainViewHorizontalOffset)
            make.height.equalTo(LayoutConstraint.mainViewHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private enum LayoutConstraint {
        static let mainViewTopOffset: CGFloat = 20
        static let mainViewHorizontalOffset: CGFloat = 25
        static let mainViewHeight: CGFloat = 160
    }
    
    private func configureBarBackButton() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratMedium(ofSize: 16)
        ]
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
            navigationItem.leftBarButtonItem = .init(
                image: .back.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(didTapBackButtonToHome)
            )
    }
    
    @objc
    private func didTapBackButtonToHome() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowDelegate = windowScene.delegate as? SceneDelegate {
            let vc = Builder.createTabBar()
            vc.tabBarController?.selectedIndex = 3
            let window = windowDelegate.window
            window?.rootViewController = vc
        }
    }
}

// MARK: - UITableViewDataSource
extension LanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LanguageCell.reuseID,
                for: indexPath) as? LanguageCell
        else {
            return UITableViewCell()
        }
        let language = presenter.languages[indexPath.row].language
        let checkValue = presenter.languages[indexPath.row].isSelected
        cell.configure(with: language)
        cell.setCheckmarkValue(checkValue)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel.makeLabel(
            font: .montserratMedium(ofSize: 15),
            color: .appTextDarkGrey,
            numberOfLines: 1
        )
        label.text = "Available Languages".localized
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectALanguage(index: indexPath.row)
        tableView.reloadData()
    }
}
