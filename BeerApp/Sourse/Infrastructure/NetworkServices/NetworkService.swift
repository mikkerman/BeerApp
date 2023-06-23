//
//  NetworkService.swift
//  BeerApp
//
//  Created by Михаил Герман on 19.06.2023.
//

import Foundation

protocol Networking {
    func fetchBeerDescription(with request: URLRequest, completion: @escaping (Result<BeerDescription, Error>) -> Void)
}

final class NetworkService: Networking {
    func fetchBeerDescription(with request: URLRequest,
                              completion: @escaping (Result<BeerDescription,
                                                     Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let beerDescription = try decoder.decode(BeerDescription.self,
                                                         from: data)
                DispatchQueue.main.async {
                    completion(.success(beerDescription))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case noData
    case invalidURL
    case serializationError
}
