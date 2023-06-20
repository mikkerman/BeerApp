//
//  CameraPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 20.06.2023.
//

import Foundation

protocol CameraPresenterProtocol: AnyObject {
    func showDescriptionWithBarcode(_ barcode: String)
}

final class CameraPresenter: CameraPresenterProtocol {
    private weak var coordinator: Coordinator?
    private let networkService: Networking
    private let baseURL: String 
    
    init(coordinator: Coordinator, networkService: Networking, baseURL: String) {
        self.coordinator = coordinator
        self.networkService = networkService
        self.baseURL = baseURL
    }
    
    func showDescriptionWithBarcode(_ barcode: String) {
        guard let url = URL(string: baseURL) else {
            log.error("Invalid base URL")
            return
        }
        
        let beerDescriptionPath = "beers"
        
        let urlWithPath = url.appendingPathComponent(beerDescriptionPath)
        var request = URLRequest(url: urlWithPath)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["barcode": barcode]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            log.error("Error serializing request body: \(error.localizedDescription)")
            return
        }
        
        networkService.fetchBeerDescription(with: request) { [weak self] result in
            switch result {
            case .success(let beerDescription):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let description = beerDescription.description
                    self.coordinator?.showDescriptionWithBarcode(description, from: self)
                }
            case .failure(let error):
                log.error("Error fetching beer description: \(error.localizedDescription)")
            }
        }
    }

}
