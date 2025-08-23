//
//  ScannerOverlayContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerOverlayContainer: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let size = CGSize(width: geometry.size.width, height: geometry.size.height)
            let length = geometry.size.width - Spacing.large * 2
            
            ZStack {
                ScannerDimView()
                ScannerCornerView()
                ScannerLineView(store: store)
                ScannerInfoContainer()
                ScannerProgressLabel()
            }
            .environment(\.scannerConfig, ScannerConfig(size: size, length: length))
        }
        .ignoresSafeArea()
    }
}
