//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//

import UIKit

final class ModuleFactory {
    // MARK: Private properties
    private var coordinator: Coordinator?
    
    // MARK: Public Methods
    func injectCoordinator(with coordinator: Coordinator) {
        if self.coordinator == nil {
            self.coordinator = coordinator
            log.debug("Coordinator injected into ModuleFactory: \(coordinator)")
        }
    }


    func buildSplashModule() -> UIViewController {
        guard let coordinator = coordinator else { return UIViewController() }
        return SplashModuleAssembler.build(coordinator: coordinator)
    }
    
    func buildCameraModule(coordinator: Coordinator) -> UIViewController {
        log.debug("Building CameraModule with Coordinator: \(coordinator)")
        return CameraModuleAssembler.build(coordinator: coordinator)
    }


    func buildDescriptionModuleWithBeerDescription(_ beerDescription: BeerDescription, coordinator: Coordinator) -> UIViewController {
        log.debug("Starting building DescriptionModule with beerDescription: \(beerDescription) and coordinator: \(coordinator)")
        
        let presenter = DescriptionPresenter(coordinator: coordinator, beerDescription: beerDescription)
        log.debug("DescriptionPresenter built: \(presenter)")

        let descriptionViewController = DescriptionViewController(presenter: presenter)
        log.debug("DescriptionViewController built: \(descriptionViewController)")

        return descriptionViewController
    }
}

