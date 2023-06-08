//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//

import UIKit

final class Coordinator {

    // MARK: Properties
    // MARK: Private properties
    private let window: UIWindow?
    private let moduleFactory: ModuleFactory

    // MARK: Init
    init(window: UIWindow?,
         moduleFactory: ModuleFactory) {
        self.window = window
        self.moduleFactory = moduleFactory
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
        let descriptionViewController = moduleFactory.buildDescriptionModuleWithBarcode(barcode, coordinator: self)
        sourceVC.present(descriptionViewController,
                         animated: true,
                         completion: nil)
    }
}
