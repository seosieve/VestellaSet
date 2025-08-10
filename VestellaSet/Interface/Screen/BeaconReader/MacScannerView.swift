//
//  MacScannerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI
import AVFoundation
import Vision

struct MacScannerView: UIViewRepresentable {
    @Binding var recognizedText: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let captureSession = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return view }
        
        captureSession.addInput(input)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        context.coordinator.captureSession = captureSession
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: MacScannerView
        var captureSession: AVCaptureSession?
        
        init(parent: MacScannerView) {
            self.parent = parent
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let request = VNRecognizeTextRequest { [weak self] request, error in
                guard let self = self else { return }
                if let observations = request.results as? [VNRecognizedTextObservation] {
                    let detectedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
                    let combinedText = detectedStrings.joined(separator: " ")
                    DispatchQueue.main.async {
                        self.parent.recognizedText = combinedText
                        
                        // 조건 체크
                        if combinedText.contains("Major") || combinedText.contains("Minor") || combinedText.count >= 12 {
                            self.captureSession?.stopRunning()
                        }
                    }
                }
            }
            request.recognitionLevel = .accurate
            
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? handler.perform([request])
        }
    }
}
