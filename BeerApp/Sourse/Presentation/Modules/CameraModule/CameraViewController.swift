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
    var scannerView = BarcodeScannerView(frame: .zero)
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
        view.backgroundColor = UIColor.beerColor
        addEllipseView()
        setupLabel()
        setupView()
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
    private func setupView() {
        scannerView = BarcodeScannerView(frame: CGRect(x: view.frame.midX - LocalConstants.scannerViewWidth / 2,
                                                       y: view.frame.midY - LocalConstants.scannerViewHeight / 2,
                                                       width: LocalConstants.scannerViewWidth,
                                                       height: LocalConstants.scannerViewHeight))
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
            lineView.widthAnchor.constraint(equalToConstant: LocalConstants.lineViewWidth),
            lineView.heightAnchor.constraint(equalToConstant: LocalConstants.lineViewHeight)
        ])

        let instructionLabel = UILabel()
        instructionLabel.text = Strings.instructionLabelText
        instructionLabel.textColor = UIColor.textColor
        instructionLabel.font = Fonts.instructionLabelFont
        instructionLabel.numberOfLines = 0
        instructionLabel.textAlignment = .center
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionLabel)
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: scannerView.bottomAnchor,
                                                  constant: LocalConstants.instructionLabelTopConstant),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: LocalConstants.textViewLeadingTrailingConstant),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -LocalConstants.textViewLeadingTrailingConstant)
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
                                 y: view.bounds.height * LocalConstants.ellipseHeightMultiplier))
        path.addQuadCurve(to: CGPoint(x: 0,
                                      y: view.bounds.height * LocalConstants.ellipseHeightMultiplier),
                          controlPoint: CGPoint(x: view.bounds.width / 2,
                                                y: view.bounds.height * LocalConstants.ellipseControlPointMultiplier))
        path.addLine(to: CGPoint(x: 0,
                                 y: 0))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }
    private func setupLabel() {
        let label = UILabel()
        label.text = Strings.appTitle
        label.textColor = UIColor.textColor
        label.font = Fonts.appNameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.labelLeadingConstant),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: LocalConstants.labelTopConstant)
        ])
    }
}

extension CameraViewController: BarcodeScannerViewDelegate {
    func barcodeScanningDidFail() {
        log.verbose("Scanning Failed. Please try again.")
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

private extension CameraViewController {
    enum LocalConstants {
        static let ellipseHeightMultiplier: CGFloat = 0.145
        static let ellipseControlPointMultiplier: CGFloat = 0.185
        static let cornerRadius: CGFloat = 10
        static let scannerViewWidth: CGFloat = 300
        static let scannerViewHeight: CGFloat = 300
        static let lineViewWidth: CGFloat = 250
        static let lineViewHeight: CGFloat = 1
        static let instructionLabelTopConstant: CGFloat = 30
        static let textViewLeadingTrailingConstant: CGFloat = 30
        static let labelLeadingConstant: CGFloat = 30
        static let labelTopConstant: CGFloat = 90
    }
}
