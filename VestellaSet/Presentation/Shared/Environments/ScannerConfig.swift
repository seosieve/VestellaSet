//
//  ScannerConfig.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI

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
