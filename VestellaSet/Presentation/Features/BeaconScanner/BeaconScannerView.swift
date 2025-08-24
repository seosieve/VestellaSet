//
//  BeaconScannerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconScannerView: View {
    let store: StoreOf<BeaconScannerFeature>
    
    @State private var macAddress: String = "텍스트 없음"
    @State private var isScanning = true
    
//    let target: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🔍 인식된 텍스트:")
                .font(.headline)
            
            Button {
                store.send(.clickBackButton)
            } label: {
                Text("Back")
            }
            
            Button {
                store.send(.clickEditorButton)
            } label: {
                Text("Go Editor")
            }

            Text(macAddress)
                .padding()
            
            OCRScannerRepresentable(result: $macAddress, isScanning: $isScanning)
                .frame(width: 200, height: 200)
        }
//        .onChange(of: isScanning) { _, scanning in
//            if !scanning { path.append(Destination.beaconEditor(macAddress: macAddress, target: target)) }
//        }
        .onAppear { isScanning = true }
        .onDisappear { isScanning = false }
        .navigationBarBackButtonHidden()
    }
}
