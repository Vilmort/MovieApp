//
//  YoutubeView.swift
//  MovieApp
//
//  Created by Victor on 02.01.2024.
//

import UIKit
import YouTubePlayerKit

final class YouTubeView: CustomView {
    private let ytPlayer = YouTubePlayerViewController()
    
    override func configure() {
        addSubview(ytPlayer.view)
        ytPlayer.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension YouTubeView: Configurable {
    struct Model {
        let link: String
    }
    
    func update(with model: Model?) {
        
        guard let model else {
            return
        }
        
        ytPlayer.player.source = .url(model.link)
        ytPlayer.player.configuration = YouTubePlayer.Configuration(
            autoPlay: false,
            showCaptions: false,
            showAnnotations: false,
            showRelatedVideos: false
        )
    }
}
