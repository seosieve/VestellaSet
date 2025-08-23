//
//  QRScannerContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI
import ComposableArchitecture

struct QRScannerContainer: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        GeometryReader { geometry in
            QRScannerRepresentable(store: store)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

