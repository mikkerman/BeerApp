//
//  File.swift
//  BeerApp
//
//  Created by Михаил Герман on 22.04.2023.
//

import UIKit

final class Coordinator {

    // MARK: Private properties
    let window: UIWindow?
    private let moduleFactory: ModuleFactory

    // MARK: Init
    init(window: UIWindow?,
         moduleFactory: ModuleFactory) {
        self.window = window
        self.moduleFactory = moduleFactory
    }

    // MARK: Public Methods
    func start() {
        let splashViewController = moduleFactory.buildSplashModule()
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
}
