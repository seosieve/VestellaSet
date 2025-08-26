//
//  QRScannerRepresentable.swift
//  VestellaSet
//
//  Created by 서충원 on 8/8/25.
//

import SwiftUI
import AVFoundation
import ComposableArchitecture

struct QRScannerRepresentable: UIViewRepresentable {
    let store: StoreOf<BeaconImportFeature>
    
    func makeUIView(context: Context) -> UIView {
        setupCamera(context: context)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Custom Camera UIView
private class CameraView: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var metadataOutput: AVCaptureMetadataOutput?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // PreviewLayer 크기 맞춤
        previewLayer?.frame = bounds
        
        // ScanOverlay 사이즈 계산
        let inset: CGFloat = Spacing.s20 * 2
        let scanSize = CGSize(width: bounds.width - inset, height: bounds.width - inset)
        let scanOrigin = CGPoint(x: (bounds.width - scanSize.width) / 2, y: (bounds.height - scanSize.height) / 2)
        let scanRect = CGRect(origin: scanOrigin, size: scanSize)
        
        // RectOfInterest 업데이트
        if let previewLayer = previewLayer, previewLayer.bounds != .zero, let metadataOutput = metadataOutput {
            metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanRect)
        }
    }
}

// MARK: - Camera Setup
private extension QRScannerRepresentable {
    func setupCamera(context: Context) -> UIView {
        let view = CameraView()
        
        let captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return view }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return view }
        guard captureSession.canAddInput(videoInput) else { return view }
        captureSession.addInput(videoInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        // previewLayer 생성
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        // CameraView 저장
        view.previewLayer = previewLayer
        view.metadataOutput = metadataOutput
        // Coordinator 저장
        context.coordinator.captureSession = captureSession
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        
        return view
    }
}

// MARK: - Coordinator
extension QRScannerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScannerRepresentable
        var captureSession: AVCaptureSession?
        
        init(_ parent: QRScannerRepresentable) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = metadataObject.stringValue else { return }
            
            let (targetList, count, major) = parseScannedCodes(stringValue)
            parent.store.send(.setTargetList(targetList))
            parent.store.send(.setMajor(major))
            parent.store.send(.setCount(count))
            parent.store.send(.stopRunning)
            captureSession?.stopRunning()
        }
        
        func parseScannedCodes(_ codes: String) -> (targetList: [String], count: Int, major: Int) {
            guard let data = codes.data(using: .utf8) else { return ([], 0, 0) }
            guard let array = try? JSONDecoder().decode([String].self, from: data), !array.isEmpty else { return ([], 0, 0) }
            let major = array.first?.components(separatedBy: " ").compactMap { Int($0) }.first ?? 0
            
            return (array, array.count, major)
        }
    }
}
