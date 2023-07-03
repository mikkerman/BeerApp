//
//  DescriptionModuleAssembler.swift
//  BeerApp
//
//  Created by Михаил Герман on 17.05.2023.
//

import UIKit

class DescriptionModuleAssembler {
    static func build(barcode: String,
                      coordinator: Coordinator,
                      beerDescriptionRepository: BeerDescriptionRepository) -> DescriptionViewController {
        let presenter = DescriptionPresenter(coordinator: coordinator,
                                             beerDescriptionRepository: beerDescriptionRepository,
                                             barcode: barcode)
        let viewController = DescriptionViewController(presenter: presenter)
        presenter.attachView(viewController) // This will make sure your presenter is properly attached to your view
        return viewController
    }
}





