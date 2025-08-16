//
//  OCRReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

struct OCRReaderView: View {
    @Binding var path: NavigationPath
    @State private var macAddress: String = "텍스트 없음"
    @State private var isScanning = true
    
    let target: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🔍 인식된 텍스트:")
                .font(.headline)
            
            Text(macAddress)
                .padding()
            
            OCRScanner(result: $macAddress, isScanning: $isScanning)
                .frame(width: 200, height: 200)
        }
        .padding()
        .onChange(of: isScanning) { _, scanning in
            if !scanning { path.append(Destination.beaconConnect(macAddress: macAddress, target: target)) }
        }
        .onAppear { isScanning = true }
        .onDisappear { isScanning = false }
    }
}
