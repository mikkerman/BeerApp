//
//  CameraViewController.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // MARK: - Properties
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beerColor
        addEllipseView()
        setupLabel()
        setupCaptureSession()
        log.verbose("ViewController has loaded its view.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startScanning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
    // MARK: - Private Methods
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        // Adding the preview layer in the middle of the screen
        let cameraView = UIView()
        cameraView.frame = CGRect(
            x: view.frame.midX - 150,
            y: view.frame.midY - 225,
            width: 300,
            height: 450)
        cameraView.layer.cornerRadius = 10
        cameraView.layer.masksToBounds = true
        cameraView.layer.addSublayer(previewLayer)
        previewLayer.frame = cameraView.bounds
        view.addSubview(cameraView)
    }
    private func startScanning() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
                self.captureSession.startRunning()
            } else {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async { [weak self] in
                            self?.captureSession.startRunning()
                        }
                    }
                }
            }
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }
    func found(code: String) {
        print(code)
    }

    private func addEllipseView() {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,
                              y: 0))
        path.addLine(to: CGPoint(x: view.frame.width,
                                 y: 0))
        path.addLine(to: CGPoint(x: view.frame.width,
                                 y: view.frame.height))
        path.addLine(to: CGPoint(x: 0,
                                 y: view.frame.height))
        path.close()
        let maskPath = UIBezierPath(roundedRect: CGRect(x: view.frame.width/2 - 150,
                                                        y: view.frame.height/2 - 225,
                                                        width: 300,
                                                        height: 450),
                                    cornerRadius: 20)
        path.append(maskPath)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.withAlphaComponent(0.7).cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        view.layer.addSublayer(shapeLayer)
    }
    private func setupLabel() {
           let label = UILabel()
           label.text = "BeerApp"
           label.textColor = UIColor.textColor
           label.font = UIFont(name: "Montserrat-Regular", size: 54)
           label.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(label)
           NSLayoutConstraint.activate([
               label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
               label.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
           ])
       }
}

// Первый вариант
// import UIKit
// import AVFoundation
//
// class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//    // MARK: - Properties
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = UIColor.beerColor
//        setupCaptureSession()
//        log.verbose("ViewController has loaded its view.")
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        if previewLayer == nil {
//            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//            let cameraView = UIView(frame: CGRect(
//                x: (view.frame.width - 300) / 2,
//                y: (view.frame.height - 450) / 2, width: 300, height: 450))
//            previewLayer.frame = cameraView.bounds
//            previewLayer.videoGravity = .resizeAspectFill
//            cameraView.layer.addSublayer(previewLayer)
//            view.addSubview(cameraView)
//        }
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        addEllipseView()
//        startScanning()
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        captureSession.stopRunning()
//    }
//    // MARK: - Private Methods
//    private func setupCaptureSession() {
//        captureSession = AVCaptureSession()
//        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
//        let videoInput: AVCaptureDeviceInput
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//        if captureSession.canAddInput(videoInput) {
//            captureSession.addInput(videoInput)
//        } else {
//            return
//        }
//        let metadataOutput = AVCaptureMetadataOutput()
//        if captureSession.canAddOutput(metadataOutput) {
//            captureSession.addOutput(metadataOutput)
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
//        } else {
//            return
//        }
//    }
//    private func startScanning() {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let self = self else { return }
//            if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
//                self.captureSession.startRunning()
//            } else {
//                AVCaptureDevice.requestAccess(for: .video) { granted in
//                    if granted {
//                        DispatchQueue.main.async {
//                            self.captureSession.startRunning()
//                        }
//                    }
//                }
//            }
//        }
//    }
//    func metadataOutput(
//        _ output: AVCaptureMetadataOutput,
//        didOutput metadataObjects: [AVMetadataObject],
//        from connection: AVCaptureConnection) {
//        captureSession.stopRunning()
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//            guard let stringValue = readableObject.stringValue else { return }
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            found(code: stringValue)
//        }
//        dismiss(animated: true)
//    }
//    func found(code: String) {
//        print(code)
//    }
//    private func addEllipseView() {
//        let shapeLayer = CAShapeLayer()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0,
//                              y: 0))
//        path.addLine(to: CGPoint(x: view.frame.width,
//                                 y: 0))
//        path.addLine(to: CGPoint(x: view.frame.width,
//                                 y: view.frame.height))
//        path.addLine(to: CGPoint(x: 0,
//                                 y: view.frame.height))
//        path.close()
//
//        let maskPath = UIBezierPath(roundedRect: CGRect(x: view.frame.width/2 - 150,
//                                                        y: view.frame.height/2 - 225,
//                                                        width: 300,
//                                                        height: 450),
//                                    cornerRadius: 20)
//        path.append(maskPath)
//        shapeLayer.path = path.cgPath
//        shapeLayer.fillColor = UIColor.black.withAlphaComponent(0.7).cgColor
//        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
//        view.layer.addSublayer(shapeLayer)
//    }
// }
//
// import UIKit
// import AVFoundation
//
// class CameraViewController: UIViewController {
//    // MARK: - Properties
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.beerColor
//        addEllipseView()
//        log.verbose("ViewController has loaded its view.")
//    }
//    // MARK: - Private Methods
//    private func addEllipseView() {
//        let shapeLayer = CAShapeLayer()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0,
//                              y: 0))
//        path.addLine(to: CGPoint(x: view.bounds.width,
//                                 y: 0))
//        path.addLine(to: CGPoint(x: view.bounds.width,
//                                 y: view.bounds.height * LocalConstants.ellipseHeightMultiplier))
//        path.addQuadCurve(to: CGPoint(x: 0,
//                                      y: view.bounds.height * LocalConstants.ellipseHeightMultiplier),
//                          controlPoint: CGPoint(x: view.bounds.width / 2,
//                                                y: view.bounds.height * 0.185))
//        path.addLine(to: CGPoint(x: 0,
//                                 y: 0))
//        shapeLayer.path = path.cgPath
//        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
//        view.layer.addSublayer(shapeLayer)
//    }
//
//    // MARK: - Constants
//    private enum LocalConstants {
//        static let ellipseHeightMultiplier: CGFloat = 0.145
//        static let cornerRadius: CGFloat = 10
//    }
