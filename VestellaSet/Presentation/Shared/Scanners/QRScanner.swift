//
//  QRScanner.swift
//  VestellaSet
//
//  Created by 서충원 on 8/8/25.
//

import SwiftUI
import AVFoundation

struct QRScanner: UIViewRepresentable {
    @Binding var result: String
    
    func makeUIView(context: Context) -> UIView {
        setupCamera(context: context)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = context.coordinator.previewLayer {
             previewLayer.frame = uiView.bounds
         }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Camera Setup
private extension QRScanner {
    func setupCamera(context: Context) -> UIView {
        let view = CameraView()  // 커스텀 UIView 사용
        
        let captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return view }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return view }
        guard captureSession.canAddInput(videoInput) else { return view }
        
        captureSession.addInput(videoInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
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

// MARK: - Custom UIView
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

// MARK: - Coordinator
extension QRScanner {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScanner
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        
        init(_ parent: QRScanner) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = metadataObject.stringValue else { return }
            parent.result = stringValue
            captureSession?.stopRunning()
        }
    }
}
