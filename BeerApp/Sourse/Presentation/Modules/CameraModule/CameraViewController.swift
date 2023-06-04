//
//  CameraViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    // MARK: - Properties
    var scannerView: BarcodeScannerView!
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames {
           for font in UIFont.fontNames(forFamilyName: family) {
              print(font)
           }
        }
        view.backgroundColor = UIColor.beerColor
        addEllipseView()
        setupLabel()
        setupScannerView()
        log.verbose("ViewController has loaded its view.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scannerView.startScanning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scannerView.stopScanning()
    }

    
    // MARK: - Private Methods
    private func setupScannerView() {
        scannerView = BarcodeScannerView(frame: CGRect(x: view.frame.midX - 150,
                                                  y: view.frame.midY - 225,
                                                  width: 300,
                                                  height: 450))
        scannerView.layer.cornerRadius = 10
        scannerView.layer.masksToBounds = true
        scannerView.delegate = self
        view.addSubview(scannerView)

        let lineView = UIView()
        lineView.backgroundColor = .red
        lineView.translatesAutoresizingMaskIntoConstraints = false
        scannerView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.centerXAnchor.constraint(equalTo: scannerView.centerXAnchor),
            lineView.centerYAnchor.constraint(equalTo: scannerView.centerYAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 250),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        let instructionLabel = UILabel()
        instructionLabel.text = "Держите штрих-код поперек красной линии"
        instructionLabel.textColor = UIColor.textColor
        instructionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        instructionLabel.numberOfLines = 0
        instructionLabel.textAlignment = .center
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionLabel)
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: scannerView.bottomAnchor, constant: 30),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    private func addEllipseView() {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,
                              y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: view.bounds.height * 0.145))
        path.addQuadCurve(to: CGPoint(x: 0,
                                      y: view.bounds.height * 0.145),
                          controlPoint: CGPoint(x: view.bounds.width / 2,
                                                y: view.bounds.height * 0.185))
        path.addLine(to: CGPoint(x: 0,
                                 y: 0))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }
    private func setupLabel() {
        let label = UILabel()
        label.text = "BeerApp"
        label.textColor = UIColor.textColor
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
        ])
    }
}

extension CameraViewController: BarcodeScannerViewDelegate {
    func barcodeScanningDidFail() {
        print("Scanning Failed. Please try again.")
    }
    func barcodeScanningSucceededWithCode(_ str: String?) {
        print("Barcode: ", str ?? "No barcode")
        if let barcode = str {
            coordinator.showDescriptionWithBarcode(barcode, from: self)
        }
    }
    func barcodeScanningDidStop() {
        print("Scanning stopped")
    }
}


