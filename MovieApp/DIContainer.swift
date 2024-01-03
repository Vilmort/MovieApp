//
//  DIContainer.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import Foundation
import KPNetwork

final class DIContainer {
    
    static let shared = DIContainer()
    
    let networkService: KPNetworkClient
    let shareService: ShareService
    
    init() {
        self.networkService = DefaultKPNetworkClient(
            baseURL:  "https://api.kinopoisk.dev/v1.4/",
            tokens: [
                "5QVH807-GAP49T6-QY0P863-EQW1F83",
                "220FRRR-ZF0M9VE-JTNC41C-FSB7ATX",
                "F6QX0P1-FQTMPFY-PWNT126-KXFHWZK"
            ]
        )
        self.shareService = ShareService()
    }
}
