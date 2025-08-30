//
//  OCROverlayContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import SwiftUI
import ComposableArchitecture

struct OCROverlayContainer: View {
    let store: StoreOf<BeaconScannerFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let length = geometry.size.width - Spacing.s20 * 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                ScannerLineView(store: store)
                ScannerProgressLabel(store: store)
            }
            .environment(\.scannerConfig, ScannerConfig(length: length, center: center))
        }
        .ignoresSafeArea()
    }
}
