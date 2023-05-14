//
//  DescriptionViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 11.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DescriptionViewController loaded")
        setupBackgroundView()
        addEllipseView()
        addImageView()
    }
    private func setupBackgroundView() {
        view.backgroundColor = UIColor.beerColor
    }
    private func addEllipseView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height * 0.145))
        path.addQuadCurve(to: CGPoint(
            x: 0,
            y: view.bounds.height * 0.145),
                          controlPoint: CGPoint(
                            x: view.bounds.width / 2,
                            y: view.bounds.height * 0.185))
        path.addLine(to: CGPoint(x: 0, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }
    private func addImageView() {
        let imageView = UIImageView()
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

}
