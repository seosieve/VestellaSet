//
//  ScannerProgressLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerProgressLabel: View {
    let store: StoreOf<BeaconImportFeature>
    
    @Environment(\.scannerConfig) var config
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.4, paused: !store.isScanning)) { _ in
            let dotCount = Int(Date().timeIntervalSinceReferenceDate / 0.4) % 4
            Text(store.textMessage + String(repeating: ".", count: dotCount))
                .foregroundStyle(Color.monoBase)
                .font(Manrope.bold(size: 16))
                .position(x: config.center.x, y: config.center.y + config.length / 2 + 36)
                .opacity(store.isScanning ? 1 : 0)
        }
    }
}
