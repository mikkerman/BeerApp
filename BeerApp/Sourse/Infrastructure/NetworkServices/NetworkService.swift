//
//  NetworkService.swift
//  BeerApp
//
//  Created by Михаил Герман on 19.06.2023.
//

import Foundation

class NetworkService {
    func fetchBeerDescription(for barcode: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://run.mocky.io/v3/7f6091a5-f415-4a49-94cd-4b6674bf115a"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let requestBody = ["barcode": barcode]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(NetworkError.serializationError))
            return
        }
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
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let description = json?["description"] as? String {
                    completion(.success(description))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case serializationError
    case invalidResponse
    case noData
    case invalidData
}
