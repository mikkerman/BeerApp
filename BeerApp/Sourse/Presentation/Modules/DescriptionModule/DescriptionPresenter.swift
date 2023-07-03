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
    private let beerDescription: BeerDescription

    // MARK: Init
    init(coordinator: Coordinator,
         beerDescription: BeerDescription) {
        self.coordinator = coordinator
        self.beerDescription = beerDescription
    }

    // MARK: Public Methods
    func fetchBeerDescription() {
        self.viewController?.setBeerDescription(beer: beerDescription)
    }

    func attachView(_ viewController: DescriptionViewController) {
        if self.viewController == nil {
            self.viewController = viewController
            fetchBeerDescription()
        }
    }
}
