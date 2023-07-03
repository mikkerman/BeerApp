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
    
    init(coordinator: Coordinator,
         beerDescriptionRepository: BeerDescriptionRepository) {
        self.coordinator = coordinator
        self.beerDescriptionRepository = beerDescriptionRepository
        log.debug("CameraPresenter initialized with Coordinator: \(coordinator)")
    }

    
    func attachView(_ view: CameraViewController) {
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func showDescriptionWithBarcode(_ barcode: String) {
        log.debug("showDescriptionWithBarcode started with barcode: \(barcode)")
        
        beerDescriptionRepository.fetchBeerDescription(with: barcode) { [weak self] result in
            switch result {
            case .success(let beerDescription):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    log.debug("Successfully fetched beer description, preparing to show on view")
                    guard let view = self.view else {
                        log.error("View is nil, cannot show beer description")
                        return
                    }
                    log.debug("About to call coordinator's showDescriptionWithBeerDescription method with view \(view)")
                    self.coordinator?.showDescriptionWithBeerDescription(beerDescription, from: view)
                }
            case .failure(let error):
                log.error("Error fetching beer description: \(error.localizedDescription)")
            }
        }
    }
    deinit {
           log.debug("CameraPresenter deinitialized")
       }
}

