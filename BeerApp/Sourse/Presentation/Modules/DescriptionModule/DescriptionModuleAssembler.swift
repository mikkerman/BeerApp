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
        let viewController = DescriptionViewController()
        let presenter = DescriptionPresenter(coordinator: coordinator,
                                             beerDescriptionRepository: beerDescriptionRepository,
                                             barcode: barcode)
        presenter.attachView(viewController)
        viewController.presenter = presenter
        return viewController
    }
}

