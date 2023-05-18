//
//  DescriptionViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 11.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    let imageView = UIImageView()
    let textView = UITextView()

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        addEllipseView()
        addImageView()
        addBeerDescription()
        log.verbose("ViewController has loaded its view.")
    }

    // MARK: - Private Methods
    private func setupBackgroundView() {
        view.backgroundColor = UIColor.beerColor
    }

    private func addEllipseView() {
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height * 0.145))
        path.addQuadCurve(to: CGPoint(x: 0, y: view.bounds.height * 0.145),
                          controlPoint: CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 0.185))
        path.addLine(to: CGPoint(x: 0, y: 0))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }

    private func addImageView() {
        imageView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.47)
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
        ])
    }

    private func addBeerDescription() {
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.beerColor

        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 45),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        textView.text = """
        Наименование:
        Guinness Draught
        Пивоварня:
        Guinness
        Стиль пива:
        Stout
        Содержание алкоголя:
        4.2%
        Горечь(IBU):
        45
        Страна происхождения:
        Ireland
        Описание:
        Black, medium-bodied, cloudy, with a rich head, medium hopped, toasted malt notes, espresso-like, coffee notes.
        """
    }
}
