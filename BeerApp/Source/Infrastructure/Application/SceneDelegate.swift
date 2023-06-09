//
//  SceneDelegate.swift
//  BeerApp
//
//  Created by Михаил Герман on 14.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return
        }

        let networkService = NetworkService()
        let beerDescriptionRepository = BeerDescriptionRepository(networkService: networkService)
        let moduleFactory = ModuleFactory()

        let coordinatorWindow = UIWindow(windowScene: windowScene)
        let coordinator = Coordinator(window: coordinatorWindow,
                                      moduleFactory: moduleFactory)

        log.debug("Coordinator initialized: \(coordinator)")

        moduleFactory.injectCoordinator(with: coordinator)

        log.debug("Coordinator injected into module factory")

        coordinator.start()


        self.window = coordinatorWindow
    }
}

