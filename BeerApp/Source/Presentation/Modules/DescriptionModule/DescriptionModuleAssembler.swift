//
//  DescriptionModuleAssembler.swift
//  BeerApp
//
//  Created by Михаил Герман on 17.05.2023.
//

import UIKit

class DescriptionModuleAssembler {
    static func build(beerDescription: BeerDescription,
                      coordinator: Coordinator) -> DescriptionViewController {
        let presenter = DescriptionPresenter(coordinator: coordinator,
                                             beerDescription: beerDescription)
        let viewController = DescriptionViewController(presenter: presenter)
        presenter.attachView(viewController)
        return viewController
    }
}





