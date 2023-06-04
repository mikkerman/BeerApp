//
//  DescriptionModuleAssembler.swift
//  BeerApp
//
//  Created by Михаил Герман on 17.05.2023.
//

import UIKit

class DescriptionModuleAssembler {
    static func build(barcode: String) -> DescriptionViewController {
        let viewController = DescriptionViewController()
        viewController.barCode = barcode
        return viewController
    }
}
