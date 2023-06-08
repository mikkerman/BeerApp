//
//  DescriptionModuleAssembler.swift
//  BeerApp
//
//  Created by Михаил Герман on 17.05.2023.
//

import UIKit

class DescriptionModuleAssembler {
    static func build(barcode: String, coordinator: Coordinator) -> DescriptionViewController {
        let viewController = DescriptionViewController()
        let presenter = DescriptionPresenter(coordinator: coordinator, barcode: barcode)
        presenter.attachView(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
