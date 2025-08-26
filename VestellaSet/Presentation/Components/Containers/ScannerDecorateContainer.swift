//
//  ScannerDecorateContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/24/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerDecorateContainer: View {
    var body: some View {
        GeometryReader { geometry in
            let size = CGSize(width: geometry.size.width, height: geometry.size.height)
            let length = geometry.size.width - Spacing.s20 * 2
            
            ZStack {
                ScannerDimView()
                ScannerCornerView()
            }
            .environment(\.scannerConfig, ScannerConfig(size: size, length: length))
        }
        .ignoresSafeArea()
    }
}
