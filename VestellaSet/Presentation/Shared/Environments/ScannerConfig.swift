//
//  ScannerConfig.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI

struct ScannerConfig {
    var length: CGFloat
    var center: CGPoint
}

private struct ScannerConfigKey: EnvironmentKey {
    static let defaultValue = ScannerConfig(length: 0, center: .zero)
}

extension EnvironmentValues {
    var scannerConfig: ScannerConfig {
        get { self[ScannerConfigKey.self] }
        set { self[ScannerConfigKey.self] = newValue }
    }
}
