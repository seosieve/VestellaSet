//
//  OCRScanner.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI
import AVFoundation
import Vision

struct OCRScanner: UIViewRepresentable {
    @Binding var result: String
    @Binding var isRunning: Bool
    
    func makeUIView(context: Context) -> UIView {
        setupCamera(context: context)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

// MARK: - Camera Setup
private extension OCRScanner {
    func setupCamera(context: Context) -> UIView {
        let view = UIView()
        
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
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        context.coordinator.captureSession = captureSession
        
        return view
    }
}

// MARK: - Coordinator
extension OCRScanner {
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: OCRScanner
        var captureSession: AVCaptureSession?
        
        init(parent: OCRScanner) {
            self.parent = parent
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let request = VNRecognizeTextRequest { [weak self] request, _ in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                guard let combinedText = self?.combineTextObservation(observations) else { return }
                
                DispatchQueue.main.async {
                    self?.parent.result = combinedText
                    self?.checkValidation(combinedText)
                }
            }
            
            request.recognitionLevel = .accurate
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? handler.perform([request])
        }
        
        private func combineTextObservation(_ observations: [VNRecognizedTextObservation]) -> String {
            let sortedObservations = observations.sorted { $0.boundingBox.origin.y < $1.boundingBox.origin.y }
            let detectedStrings = sortedObservations.compactMap { $0.topCandidates(1).first?.string }
            return detectedStrings.joined(separator: " ")
        }
        
        private func checkValidation(_ combinedText: String) {
            guard combinedText.contains("Major"), combinedText.contains("Minor") else { return }
            
            let prefix = String(combinedText.prefix(12))
            guard !prefix.contains(where: { $0.isWhitespace }) else { return }
            
            let pattern = "^[A-Z0-9]{12}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            
            guard predicate.evaluate(with: prefix) else { return }
            
            captureSession?.stopRunning()
            
            DispatchQueue.main.async { [weak self] in
                self?.parent.isRunning = false
            }
        }
    }
}
