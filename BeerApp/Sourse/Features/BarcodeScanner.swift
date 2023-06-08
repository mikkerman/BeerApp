//
//  BarcodeScanner.swift
//  BeerApp
//
//  Created by Михаил Герман on 23.05.2023.
//
import AVFoundation
import UIKit

// MARK: - BarcodeScannerViewDelegate Protocol
protocol BarcodeScannerViewDelegate: AnyObject {
    func barcodeScanningDidFail()
    func barcodeScanningSucceededWithCode(_ str: String?)
    func barcodeScanningDidStop()
}
// MARK: - BarcodeScannerView
class BarcodeScannerView: UIView {
    // MARK: - Public Properties
    weak var delegate: BarcodeScannerViewDelegate?
    // MARK: - Private Properties
    private var captureSession = AVCaptureSession()
    // MARK: - Computed Properties
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: captureSession)
        return layer
    }()
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCaptureSession()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCaptureSession()
    }
    // MARK: - Public Methods
    func startScanning() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    func stopScanning() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.stopRunning()
        }
    }
    // MARK: - Private Methods
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.barcodeScanningDidFail()
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.barcodeScanningDidFail()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            delegate?.barcodeScanningDidFail()
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
    }
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension BarcodeScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.barcodeScanningSucceededWithCode(stringValue)
        }
    }
}
