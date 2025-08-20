//
//  GeometryQRScanner.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI
import ComposableArchitecture

struct GeometryQRScanner: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        GeometryReader { geometry in
            QRScanner(store: store)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

