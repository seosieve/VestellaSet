//
//  RadarConfig.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import SwiftUI

struct RadarConfig {
    var length: CGFloat
}

private struct RadarConfigKey: EnvironmentKey {
    static let defaultValue = RadarConfig(length: 0)
}

extension EnvironmentValues {
    var radarConfig: RadarConfig {
        get { self[RadarConfigKey.self] }
        set { self[RadarConfigKey.self] = newValue }
    }
}
