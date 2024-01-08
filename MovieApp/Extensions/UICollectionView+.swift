//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//

import UIKit

extension UICollectionView.SupplementaryRegistration<HeaderView> {
    var headerProvider: (UICollectionView, String, IndexPath) -> HeaderView {
        { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self,
                for: indexPath
            )
        }
    }
}
