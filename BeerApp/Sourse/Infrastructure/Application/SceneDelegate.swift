//
//  SceneDelegate.swift
//  BeerApp
//
//  Created by Михаил Герман on 14.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let moduleFactory = ModuleFactory()

        let coordinator = Coordinator(window: UIWindow(windowScene: windowScene), moduleFactory: moduleFactory)
        moduleFactory.injectCoordinator(with: coordinator)

        coordinator.start()

        self.window = coordinator.window
    }
}
