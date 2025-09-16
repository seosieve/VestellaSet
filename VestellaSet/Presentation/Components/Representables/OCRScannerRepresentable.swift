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
        setupCamera(context: context)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
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
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // coordinator에 previewLayer 저장
        context.coordinator.previewLayer = previewLayer
        context.coordinator.captureSession = captureSession
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        
        return view
    }
}

// MARK: - Coordinator
extension OCRScannerRepresentable {
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: OCRScannerRepresentable
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        private var sendFlag = false
        
        init(parent: OCRScannerRepresentable) {
            self.parent = parent
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let request = VNRecognizeTextRequest { [weak self] request, _ in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                guard let combinedText = self?.combineTextObservation(observations) else { return }
                self?.checkValidation(combinedText)
            }
            
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["en-US"]
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? handler.perform([request])
        }
        
        private func combineTextObservation(_ observations: [VNRecognizedTextObservation]) -> String {
            let detectedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            return detectedStrings.joined(separator: " ")
        }
        
        private func checkValidation(_ combinedText: String) {
            let parts = combinedText.components(separatedBy: " ")
            
            // 1. 중복 실행 방지 Flag 처리
            guard !sendFlag else { return }
            
            // 2. Major, Minor 포함 텍스트
            guard parts.first(where: { $0.localizedCaseInsensitiveContains("Major") }) != nil else { return }
            guard parts.first(where: { $0.localizedCaseInsensitiveContains("Minor") }) != nil else { return }
            
            // 3. MBeacon, MiniBeacon 통합 감지 로직
            let pattern = "^(\(Minew.mini)\\d{5}|[A-Z0-9]{12})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            guard let identifier = parts.first(where: { predicate.evaluate(with: $0) }) else { return }
            
            sendFlag = true
            
            DispatchQueue.main.async { [weak self] in
                self?.parent.store.send(.stopScanning)
                self?.parent.store.send(.setIdentifier(identifier))
            }
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession?.stopRunning()
            }
        }
    }
}
