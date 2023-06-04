//
//  CameraPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//

import UIKit

class CameraModuleAssembler {
    static func build(coordinator: Coordinator) -> CameraViewController {
        let viewController = CameraViewController(coordinator: coordinator)
        return viewController
    }

}
