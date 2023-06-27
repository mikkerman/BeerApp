//
//  CameraPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//
import Foundation

class CameraModuleAssembler {
    static func build(coordinator: Coordinator) -> CameraViewController {
        let networkService = NetworkService()
        let beerDescriptionRepository = BeerDescriptionRepository(networkService: networkService)
        let presenter = CameraPresenter(coordinator: coordinator, beerDescriptionRepository: beerDescriptionRepository)
        return CameraViewController(presenter: presenter)
    }
}
