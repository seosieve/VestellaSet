//
//  OCRScannerContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/24/25.
//

import SwiftUI
import ComposableArchitecture

struct OCRScannerContainer: View {
    let store: StoreOf<BeaconScannerFeature>
    
    var body: some View {
        GeometryReader { geometry in
            OCRScannerRepresentable(store: store)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}
