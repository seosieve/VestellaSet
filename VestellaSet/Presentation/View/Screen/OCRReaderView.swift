//
//  OCRReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

struct OCRReaderView: View {
    @ObservedObject var model: BeaconDataViewModel
    @State private var macAddress: String = "텍스트 없음"
    @State private var isScanning = true
    @State private var isPresented = false
    
    let item: String
    
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
        .navigationDestination(isPresented: $isPresented) {
            BeaconConnectView(model: model, macAddress: macAddress, item: item)
        }
        .onChange(of: isScanning) { _, scanning in
            isPresented = !scanning
        }
        .onAppear { isScanning = true }
        .onDisappear { isScanning = false }
    }
}
