//
//  BeaconImportView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconImportView: View {
    let store: StoreOf<BeaconImportFeature>
    
    @State private var scannedCode = "스캔 댐"
    
    var body: some View {
        ZStack {
            GeometryQRScanner(store: store)
            ScannerOverlayView(store: store)
            
            VStack {
                BackButton(store: store)
                ScanInfoContainer()
                ProgressLabel()
                Spacer()
                ActionButton(store: store, title: "Save") {
                    print("버튼 눌림")
                }
            }
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
