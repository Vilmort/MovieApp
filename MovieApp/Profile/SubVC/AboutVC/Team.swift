//
//  Team.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import UIKit

struct TeamPayer {
    let image: UIImage
    let role: String
    let gitHub: String
}

struct Team {
    static let team: [TeamPayer] = [
        TeamPayer(image: .profilePicture2,
                  role: "TeamLeader".localized,
                  gitHub: "https://github.com/Vanopr"),
        TeamPayer(image: .profilePicture1,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/viktorporch"),
        TeamPayer(image: .profilePicture1,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/Nodnet")
    ]
}
