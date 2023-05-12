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
    func injectView(with view: SplashViewProtocol) {
        if self.view == nil { self.view = view }
    }

    func viewDidLoad() {
        print("SplashPresenter received viewDidLoad")
        navigateToDescriptionAfterDelay()
    }

    // MARK: Private Methods
    private func navigateToDescriptionAfterDelay() {
        print("Starting delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Delay finished, navigating to Description")
            self.coordinator.showDescription()
        }
    }
}
