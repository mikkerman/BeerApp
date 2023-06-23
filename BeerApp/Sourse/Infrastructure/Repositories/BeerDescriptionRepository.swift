//
//  BeerDescriptionRepository.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.06.2023.
//

import Foundation

protocol BeerDescriptionRepositoryProtocol {
    func fetchBeerDescription(with barcode: String,
                              completion: @escaping (Result<BeerDescription,
                                                     Error>) -> Void)
}

final class BeerDescriptionRepository: BeerDescriptionRepositoryProtocol {
    private let networkService: Networking
    private let baseURL: String
    init(networkService: Networking) {
        self.networkService = networkService
        self.baseURL = APIConstants.baseURL
    }
    func fetchBeerDescription(with barcode: String,
                              completion: @escaping (Result<BeerDescription,
                                                     Error>) -> Void) {
        let beerDescriptionPath = APIConstants.beerDescriptionPath
        guard let url = URL(string: baseURL + beerDescriptionPath) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        let requestBody = ["barcode": barcode]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody,
                                                      options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(NetworkError.serializationError))
            return
        }
        networkService.fetchBeerDescription(with: request) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
