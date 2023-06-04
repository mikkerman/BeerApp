//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//

import UIKit

final class ModuleFactory {

    // MARK: Private properties
    private weak var coordinator: Coordinator?
    // MARK: Public Methods
    func injectCoordinator(with coordinator: Coordinator) {
        if self.coordinator == nil { self.coordinator = coordinator }
    }

    func buildSplashModule() -> UIViewController {
        guard let coordinator = coordinator else { return UIViewController() }
        return SplashModuleAssembler.build(coordinator: coordinator)
    }
    func buildCameraModule(coordinator: Coordinator) -> UIViewController {
        return CameraModuleAssembler.build(coordinator: coordinator)
    }

    func buildDescriptionModuleWithBarcode(_ barcode: String) -> UIViewController {
        let descriptionViewController = DescriptionModuleAssembler.build(barcode: barcode)
        return descriptionViewController
    }
    func buildDescriptionModule(barcode: String) -> DescriptionViewController {
        let viewController = DescriptionViewController()
        viewController.barCode = barcode
        return viewController
    }


    // MARK: Private methods
}
