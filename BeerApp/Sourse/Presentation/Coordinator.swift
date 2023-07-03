//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//
import UIKit

final class Coordinator {
    private let window: UIWindow?
    private let moduleFactory: ModuleFactory
    
    init(window: UIWindow?, moduleFactory: ModuleFactory) {
        self.window = window
        self.moduleFactory = moduleFactory
        log.debug("Coordinator initialized: \(self)")
    }
    
    // MARK: Public Methods
    func start() {
        log.debug("Starting Coordinator: \(self)")
        let splashViewController = moduleFactory.buildSplashModule()
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
    
    func showCamera() {
        log.debug("Attempting to show Camera with Coordinator: \(self)")
        let cameraViewController = moduleFactory.buildCameraModule(coordinator: self)
        window?.rootViewController = cameraViewController
    }
    
    func showDescriptionWithBeerDescription(_ beerDescription: BeerDescription, from sourceVC: UIViewController) {
        log.verbose("showDescriptionWithBeerDescription called with beerDescription: \(beerDescription)")
        log.debug("About to build DescriptionModule with beerDescription \(beerDescription) and Coordinator: \(self)")
        
        let descriptionViewController = moduleFactory.buildDescriptionModuleWithBeerDescription(beerDescription, coordinator: self)
        
        log.debug("DescriptionModule built, about to present it from \(sourceVC)")
        
        guard let _ = descriptionViewController.view else {
            log.error("descriptionViewController's view is not loaded")
            return
        }
        
        log.debug("descriptionViewController view is loaded")
        
        DispatchQueue.main.async {
            descriptionViewController.modalPresentationStyle = .fullScreen
            sourceVC.present(descriptionViewController, animated: true) {
                log.debug("descriptionViewController is presented")
            }
        }
        
    }
    
    deinit {
        log.debug("Coordinator deinitialized")
    }
}
