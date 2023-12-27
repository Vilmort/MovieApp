//
//  SceneDelegate.swift
//  Movie
//
//  Created by Vanopr on 24.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        var vc: UIViewController
        UDService.ifOnboardingCompleted() ? 
        (vc =  Builder.createTabBar()) :
        (vc = Builder.createOnboarding())
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        navigationController.navigationBar.isHidden = true
        window?.makeKeyAndVisible()
    }
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }




