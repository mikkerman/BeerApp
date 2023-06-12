//
//  DescriptionPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 08.06.2023.
//

import UIKit

final class DescriptionPresenter {
    // MARK: Private properties
    private weak var viewController: DescriptionViewController?
    private let coordinator: Coordinator
    private let barcode: String
    // MARK: Init
    init(coordinator: Coordinator,
         barcode: String) {
        self.coordinator = coordinator
        self.barcode = barcode
    }
    // MARK: Public Methods
    func attachView(_ viewController: DescriptionViewController) {
        if self.viewController == nil {
            self.viewController = viewController
        }
    }
}
