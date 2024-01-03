//
//  ShareService.swift
//  MovieApp
//
//  Created by Victor on 03.01.2024.
//

import UIKit

final class ShareService {
    static let shared = ShareService()
    
    private init () { }
    private var coveringWindow: UIWindow?
    
    private func getAvailableServices() -> [App] {
        App.allCases.filter {
            guard let url = $0.uri("test") else {
                return false
            }
            return UIApplication.shared.canOpenURL(url)
        }
    }
    
    func showShare(_ text: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let windowFrame = UIApplication.shared.keyWindow?.frame else {
            return
        }
        
        let controller = UIViewController()
        let coveringWindow = UIWindow(windowScene: windowScene)
        coveringWindow.frame = windowFrame
        coveringWindow.windowLevel = .alert
        coveringWindow.rootViewController = controller
        coveringWindow.makeKeyAndVisible()
        self.coveringWindow = coveringWindow
        
        let shareView = ShareView()
        shareView.update(
            with: .init(
                share: getAvailableServices().map {
                    share in
                        .init(
                            image: share.icon.withRenderingMode(.alwaysOriginal),
                            action: {
                                UIApplication.shared.open(share.uri(text)!)
                            }
                        )
                } + (URL(string: text) != nil ? [
                    .init(
                        image: App.other.icon,
                        action: {
                            let vc = UIActivityViewController(activityItems: [URL(string: text)!], applicationActivities: nil)
                            controller.present(vc, animated: true)
                        }
                    )
                ] : []),
                onClose: {
                    [weak self] in
                    
                    self?.coveringWindow?.isHidden = true
                    self?.coveringWindow = nil
                }
            )
        )
        coveringWindow.addSubview(shareView)
        shareView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        shareView.animate()
    }
}

extension ShareService {
    
    struct ShareApp {
        let type: App
        let icon: UIImage
        let shareAction: () -> Void
    }
    
    enum App: CaseIterable {
        case imessage, telegram, whatsapp, other
        
        func uri(_ text: String) -> URL? {
            switch self {
            case .telegram:
                return URL(string: "tg://msg?text=\(text)")
            case .whatsapp:
                return URL(string: "whatsapp://send?text=\(text)")
            case .imessage:
                return URL(string: "sms:?&body=\(text)")
            default:
                return nil
            }
        }
        
        var icon: UIImage {
            switch self {
            case .telegram:
                return .Socials.tg
            case .whatsapp:
                return .Socials.whatsapp
            case .imessage:
                return .Socials.imessage
            case .other:
                return .Socials.other.withRenderingMode(.alwaysTemplate)
            }
        }
    }
}
