//
//  OCRScannerRepresentable.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI
import AVFoundation
import Vision
import ComposableArchitecture

struct OCRScannerRepresentable: UIViewRepresentable {
    let store: StoreOf<BeaconScannerFeature>
    
    func makeUIView(context: Context) -> UIView {
        let view = setupCamera(context: context)
        context.coordinator.startScanning()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = context.coordinator.previewLayer {
            previewLayer.frame = uiView.bounds
        }
        
        if store.isRunning { context.coordinator.startScanning() }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

// MARK: - Camera Setup
private extension OCRScannerRepresentable {
    // Custom Camera UIView
    class CameraView: UIView {
        override func layoutSubviews() {
            super.layoutSubviews()
            // 서브레이어의 프레임을 현재 뷰 크기에 맞춤
            layer.sublayers?.forEach { sublayer in
                if sublayer is AVCaptureVideoPreviewLayer {
                    sublayer.frame = bounds
                }
            }
        }
    }
    
    func setupCamera(context: Context) -> UIView {
        let view = CameraView()
        
        let captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return view }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return view }
        
        captureSession.addInput(videoInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // coordinator에 previewLayer 저장
        context.coordinator.previewLayer = previewLayer
        context.coordinator.captureSession = captureSession
        
        return view
    }
}

// MARK: - Coordinator
extension OCRScannerRepresentable {
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: OCRScannerRepresentable
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        
        init(parent: OCRScannerRepresentable) {
            self.parent = parent
        }
        
        func startScanning() {
            guard let session = captureSession, !session.isRunning else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }
        }
        
        func stopScanning() {
            captureSession?.stopRunning()
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let request = VNRecognizeTextRequest { [weak self] request, _ in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                guard let combinedText = self?.combineTextObservation(observations) else { return }
                self?.checkValidation(combinedText)
            }
            
            request.recognitionLevel = .accurate
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? handler.perform([request])
        }
        
        private func combineTextObservation(_ observations: [VNRecognizedTextObservation]) -> String {
            let detectedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            return detectedStrings.joined(separator: " ")
        }
        
        private func checkValidation(_ combinedText: String) {
            let parts = combinedText.components(separatedBy: " ")
            
            // 1. Major 포함 텍스트
            guard parts.first(where: { $0.localizedCaseInsensitiveContains("Major") }) != nil else { return }
            
            // 2. Minor 포함 텍스트
            guard parts.first(where: { $0.localizedCaseInsensitiveContains("Minor") }) != nil else { return }
            
            // 3. 12글자 MAC 주소 (공백 없이 대문자/숫자)
            let macPattern = "^[A-Z0-9]{12}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", macPattern)
            guard let macAddress = parts.first(where: { predicate.evaluate(with: $0) })?.lowercased() else { return }
            
            stopScanning()
            
            parent.store.send(.stopRunning)
            parent.store.send(.setMacAddress(macAddress))
        }
    }
}
