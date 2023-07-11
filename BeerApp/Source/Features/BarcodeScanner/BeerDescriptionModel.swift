//
//  BeerDescriptionModel.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.06.2023.
//

import Foundation

struct BeersResponse: Decodable {
    let beers: [BeerDescription]
}
struct BeerDescription: Decodable {
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
