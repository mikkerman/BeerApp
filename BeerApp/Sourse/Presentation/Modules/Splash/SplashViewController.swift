//
//  SplashViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 16.04.2023.
//

import UIKit

protocol SplashViewProtocol: AnyObject {

}

class SplashViewController: UIViewController {

    // MARK: Private properties
    private let presenter: SplashPresenter
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        print("SplashViewController loaded")
    }

    // MARK: Init
    init(presenter: SplashPresenter) {
        self.presenter = presenter
        super.init(nibName: nil,
                   bundle: nil)
        self.view.backgroundColor = .purple // test
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension SplashViewController + SplashViewProtocol -
extension SplashViewController: SplashViewProtocol {

}
