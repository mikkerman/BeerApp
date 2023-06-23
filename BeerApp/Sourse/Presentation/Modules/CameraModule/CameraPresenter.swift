//
//  CameraPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 20.06.2023.
//

import Foundation

// MARK: - CameraPresenterProtocol

protocol CameraPresenterProtocol: AnyObject {
    func attachView(_ view: CameraViewController)
    func detachView()
    func showDescriptionWithBarcode(_ barcode: String)
}

// MARK: - CameraPresenter

final class CameraPresenter: CameraPresenterProtocol {
    private weak var coordinator: Coordinator?
    private let beerDescriptionRepository: BeerDescriptionRepository
    private weak var view: CameraViewController?

    init(coordinator: Coordinator, beerDescriptionRepository: BeerDescriptionRepository) {
        self.coordinator = coordinator
        self.beerDescriptionRepository = beerDescriptionRepository
    }

    func attachView(_ view: CameraViewController) {
        self.view = view
    }
    func detachView() {
        view = nil
    }
    func showDescriptionWithBarcode(_ barcode: String) {
        beerDescriptionRepository.fetchBeerDescription(with: barcode) { [weak self] result in
            switch result {
            case .success(let beerDescription):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, let view = self.view else { return }
                    let description = beerDescription.description
                    self.coordinator?.showDescriptionWithBarcode(description, from: view)
                }
            case .failure(let error):
                log.error("Error fetching beer description: \(error.localizedDescription)")
            }
        }
    }
}
