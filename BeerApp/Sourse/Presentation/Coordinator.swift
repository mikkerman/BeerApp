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
    private let beerDescriptionRepository: BeerDescriptionRepository

    init(window: UIWindow?, moduleFactory: ModuleFactory, beerDescriptionRepository: BeerDescriptionRepository) {
        self.window = window
        self.moduleFactory = moduleFactory
        self.beerDescriptionRepository = beerDescriptionRepository
    }

    // MARK: Public Methods
    func start() {
        let splashViewController = moduleFactory.buildSplashModule()
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
    
    func showCamera() {
        let cameraViewController = moduleFactory.buildCameraModule(coordinator: self)
        window?.rootViewController = cameraViewController
    }
    
    func showDescriptionWithBarcode(_ barcode: String, from sourceVC: UIViewController) {
        log.verbose("showDescriptionWithBarcode called with barcode: \(barcode)")
        let descriptionViewController = moduleFactory.buildDescriptionModuleWithBarcode(barcode, coordinator: self, beerDescriptionRepository: self.beerDescriptionRepository)
        descriptionViewController.modalPresentationStyle = .fullScreen
        sourceVC.present(descriptionViewController,
                         animated: true,
                         completion: nil)
    }
}
