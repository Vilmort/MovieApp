//
//  AboutViewController.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit
import SnapKit
import SafariServices


final class AboutUsViewController: ViewController, AboutViewControllerProtocol {
    
    
    var presenter: AboutUsPresenterProtocol!
    
    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TeamViewCell.self, forCellWithReuseIdentifier: "TeamViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isTranslucent = true
        view.backgroundColor = .appDark
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        title = "Team".localized
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

extension AboutUsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Team.team.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamViewCell", for: indexPath) as? TeamViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: Team.team[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = Team.team[indexPath.row].gitHub
        if let url = URL(string: url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 80)
    }
}
