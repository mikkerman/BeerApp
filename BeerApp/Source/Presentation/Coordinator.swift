//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//

import UIKit

final class Coordinator {
    private let window: UIWindow?
    private let navigationController: UINavigationController
    private let moduleFactory: ModuleFactory
    
    init(window: UIWindow?, moduleFactory: ModuleFactory) {
        self.window = window
        self.navigationController = UINavigationController()
        self.moduleFactory = moduleFactory
        window?.rootViewController = navigationController
        log.debug("Coordinator initialized: \(self)")
    }
    
    // MARK: Public Methods
    func start() {
        log.debug("Starting Coordinator: \(self)")
        let splashViewController = moduleFactory.buildSplashModule()
        navigationController.viewControllers = [splashViewController]
        window?.makeKeyAndVisible()
    }
    
    func showCamera() {
        log.debug("Attempting to show Camera with Coordinator: \(self)")
        let cameraViewController = moduleFactory.buildCameraModule(coordinator: self)
        navigationController.viewControllers = [cameraViewController]
    }
    
    func showDescriptionWithBeerDescription(_ beerDescription: BeerDescription, from sourceVC: UIViewController) {
        log.verbose("showDescriptionWithBeerDescription called with beerDescription: \(beerDescription)")
        log.debug("About to build DescriptionModule with beerDescription \(beerDescription) and Coordinator: \(self)")
        let descriptionViewController = moduleFactory.buildDescriptionModuleWithBeerDescription(beerDescription, coordinator: self)
        log.debug("DescriptionModule built, about to present it from \(sourceVC)")
        navigationController.pushViewController(descriptionViewController, animated: true)
    }
    deinit {
        log.debug("Coordinator deinitialized")
    }
}

