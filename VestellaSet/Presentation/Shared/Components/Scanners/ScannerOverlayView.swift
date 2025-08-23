//
//  ScannerOverlayView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI

struct ScannerOverlayView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = CGSize(width: geometry.size.width, height: geometry.size.height)
            let length = geometry.size.width - Spacing.normal * 2
            
            ZStack {
                ScannerDimView()
                ScannerCornerView()
                ScannerLineView()
            }
            .environment(\.scannerConfig, ScannerConfig(size: size, length: length))
        }
        .ignoresSafeArea()
    }
}

struct ScannerConfig {
    var size: CGSize
    var length: CGFloat
    var center: CGPoint { CGPoint(x: size.width / 2, y: size.height / 2) }
}

private struct ScannerConfigKey: EnvironmentKey {
    static let defaultValue = ScannerConfig(size: .zero, length: 0)
}

extension EnvironmentValues {
    var scannerConfig: ScannerConfig {
        get { self[ScannerConfigKey.self] }
        set { self[ScannerConfigKey.self] = newValue }
    }
}
