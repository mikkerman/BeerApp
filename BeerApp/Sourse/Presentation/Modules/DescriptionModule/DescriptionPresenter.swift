//
//  DescriptionPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 08.06.2023.
//

final class DescriptionPresenter {
    // MARK: Private properties
    private weak var viewController: DescriptionViewController?
    private let coordinator: Coordinator
    private let barcode: String
    private let beerDescriptionRepository: BeerDescriptionRepository

    // MARK: Init
    init(coordinator: Coordinator,
         beerDescriptionRepository: BeerDescriptionRepository,
         barcode: String) {
        self.coordinator = coordinator
        self.beerDescriptionRepository = beerDescriptionRepository
        self.barcode = barcode
    }

    // MARK: Public Methods
    func fetchBeerDescription() {
        beerDescriptionRepository.fetchBeerDescription(with: barcode) { [weak self] result in
            switch result {
            case .success(let beerDescription):
                self?.viewController?.setBeerDescription(beer: beerDescription)
            case .failure(let error):
                log.error("Error fetching beer description: \(error.localizedDescription)")
            }
        }
    }

    func attachView(_ viewController: DescriptionViewController) {
        if self.viewController == nil {
            self.viewController = viewController
            fetchBeerDescription()
        }
    }
}
