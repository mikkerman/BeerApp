////
////  BarcodeScanner.swift
////  BeerApp
////
////  Created by Михаил Герман on 23.05.2023.
////
//
// import AVFoundation
//
// class BarcodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
//     var captureSession: AVCaptureSession?
//    
////    func startScanning() {
////        guard let captureDevice = AVCaptureDevice.default(for: .video),
////              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
////            // Обработка ошибки при доступе к камере
//            return
//        }
//        
//        captureSession = AVCaptureSession()
//        captureSession?.addInput(input)
//        
//        let metadataOutput = AVCaptureMetadataOutput()
//        captureSession?.addOutput(metadataOutput)
//        
//        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        metadataOutput.metadataObjectTypes = [.ean13]
//        
//        captureSession?.startRunning()
//    }
//    
//    // Метод делегата AVCaptureMetadataOutputObjectsDelegate, вызывается при обнаружении штрихкода
//    func metadataOutput(_ output: AVCaptureMetadataOutput,
// didOutput metadataObjects: [AVMetadataObject],
// from connection: AVCaptureConnection) {
//        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
//           let barcodeValue = metadataObject.stringValue {
//            // Штрихкод был обнаружен, выполните необходимые действия
//            processBarcodeValue(barcodeValue)
//        }
//    }
//    
//    private func processBarcodeValue(_ barcodeValue: String) {
//        // Обработка значения штрихкода, например, перенаправление на DescriptionViewController
////        let descriptionVC = DescriptionViewController(barcodeValue: barcodeValue)
////        UIApplication.shared.windows.first?.rootViewController?.present(descriptionVC, animated: true, completion: nil)
//    }
// }
