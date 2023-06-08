//
//  SplashPresenter.swift
//  BeerApp
//
//  Created by Михаил Герман on 16.04.2023.
//

import UIKit

final class SplashPresenter {

    // MARK: Private properties
    private weak var view: SplashViewProtocol?
    private let coordinator: Coordinator
    // MARK: Init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public Methods
    func pushSplash(with view: SplashViewProtocol) {
        if self.view == nil { self.view = view }
    }

    func viewWillAppear() {
        coordinator.showCamera()
    }
}
