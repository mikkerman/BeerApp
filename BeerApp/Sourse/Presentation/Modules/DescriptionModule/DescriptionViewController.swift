//
//  DescriptionViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 11.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    // MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private let imageView = UIImageView()
    private let textView = UITextView()
    var beerDescription: BeerDescription? // Added
    var presenter: DescriptionPresenter?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beerColor
        addEllipseView()
        addImageView()
        addBeerDescription()
        if let beer = beerDescription {
            setBeerDescription(beer: beer)
        }
        log.verbose("ViewController has loaded its view.")
    }
    // MARK: - Public Methods
    func setBeerDescription(beer: BeerDescription) {
        let descriptionText = """
        Наименование:
        \(beer.name)
        Пивоварня:
        \(beer.brewery)
        Стиль пива:
        \(beer.beerStyle)
        Содержание алкоголя:
        \(beer.alcoholContent)
        Горечь(IBU):
        \(beer.bitternessIBU)
        Страна происхождения:
        \(beer.countryOfOrigin)
        Описание:
        \(beer.description)
        """
        textView.text = descriptionText
    }

    // MARK: - Private Methods
    private func addEllipseView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,
                              y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: view.bounds.height * LocalConstants.ellipseHeightMultiplier))
        path.addQuadCurve(to: CGPoint(x: 0,
                                      y: view.bounds.height * LocalConstants.ellipseHeightMultiplier),
                          controlPoint: CGPoint(x: view.bounds.width / 2,
                                                y: view.bounds.height * 0.185))
        path.addLine(to: CGPoint(x: 0,
                                 y: 0))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }

    private func addImageView() {
        imageView.backgroundColor = UIColor.photoColor
        imageView.layer.cornerRadius = LocalConstants.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: LocalConstants.imageViewWidthMultiplier),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 45)
        ])
    }

    private func addBeerDescription() {
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = Fonts.descriptionFont
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.beerColor
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                          constant: 30),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                             constant: -20)
        ])
    }
}

// MARK: - Constants
private extension DescriptionViewController {
    enum LocalConstants {
        static let ellipseHeightMultiplier: CGFloat = 0.145
        static let cornerRadius: CGFloat = 10
        static let imageViewWidthMultiplier: CGFloat = 0.5
        static let textViewLeadingConstant: CGFloat = 20
        static let textViewTrailingConstant: CGFloat = -20
        static let textViewBottomConstant: CGFloat = -20
    }
}
