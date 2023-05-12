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
    }
    private func setupBackgroundView() {
        view.backgroundColor = UIColor.beerColor
    }
    private func addEllipseView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height * 0.75))
        path.addQuadCurve(to: CGPoint(
            x: 0,
            y: view.bounds.height * 0.3),
                          controlPoint: CGPoint(
                            x: view.bounds.width / 2,
                            y: view.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }

}
