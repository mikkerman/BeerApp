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
    private let baseURL = URL(string: "https://run.mocky.io/v3/")!
    private let beerDescriptionPath = "7f6091a5-f415-4a49-94cd-4b6674bf115a"
    
    func fetchBeerDescription(with request: URLRequest, completion: @escaping (Result<BeerDescription, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let beerDescription = try decoder.decode(BeerDescription.self, from: data)
                completion(.success(beerDescription))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

struct BeerDescription: Codable {
    let id: String
    let name: String
    let brewery: String
    let beerStyle: String
    let alcoholContent: String
    let bitternessIBU: String
    let countryOfOrigin: String
    let description: String
    let barcode: String
}


enum NetworkError: Error {
    case invalidResponse
    case noData
}
