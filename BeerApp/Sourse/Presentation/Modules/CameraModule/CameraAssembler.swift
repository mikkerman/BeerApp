//
//  CameraPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//

import UIKit

class CameraModuleAssembler {
    static func build(coordinator: Coordinator) -> CameraViewController {
        let networkService = NetworkService()
        let presenter = CameraPresenter(coordinator: coordinator, networkService: networkService, baseURL: "https://run.mocky.io/v3/7f6091a5-f415-4a49-94cd-4b6674bf115a")
        return CameraViewController(presenter: presenter)
    }
}
