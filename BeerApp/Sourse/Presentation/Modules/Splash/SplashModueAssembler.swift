//
//  SplashModueAssembler.swift
//  BeerApp
//
//  Created by Михаил Герман on 16.04.2023.
//

import UIKit

struct SplashModuleAssembler {

    // MARK: Init
    private init() {}

    // MARK: Public Methods
    static func build(coordinator: Coordinator) -> UIViewController {
        let presenter = SplashPresenter(coordinator: coordinator)
        let view = SplashViewController(presenter: presenter)
        presenter.injectView(with: view)
        return view
    }
}
