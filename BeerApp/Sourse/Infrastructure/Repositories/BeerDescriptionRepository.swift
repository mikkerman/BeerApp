//
//  BeerDescriptionRepository.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.06.2023.
//

import Foundation

protocol BeerDescriptionRepositoryProtocol {
    func fetchBeerDescription(with barcode: String, completion: @escaping (Result<BeerDescription, Error>) -> Void)
}

final class BeerDescriptionRepository: BeerDescriptionRepositoryProtocol {
    private let networkService: Networking
    private let baseURL: String
    
    init(networkService: Networking) {
        self.networkService = networkService
        self.baseURL = APIConstants.baseURL
    }
    
    func fetchBeerDescription(with barcode: String, completion: @escaping (Result<BeerDescription, Error>) -> Void) {
        log.debug("fetchBeerDescription started with barcode: \(barcode)")
        
        let beerDescriptionPath = APIConstants.beerDescriptionPath
        guard let url = URL(string: baseURL + beerDescriptionPath) else {
            log.error("Invalid URL for beer description path")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestBody = ["barcode": barcode]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            log.error("Serialization error: \(error)")
            completion(.failure(NetworkError.serializationError))
            return
        }
        
        networkService.performRequest(with: request) { (result: Result<BeersResponse, Error>) in
            switch result {
            case .success(let beersResponse):
                if let beer = beersResponse.beers.first(where: { $0.barcode == barcode }) {
                    log.debug("Successfully fetched beer description")
                    completion(.success(beer))
                } else {
                    log.error("No data for given barcode")
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                log.error("Network request error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
