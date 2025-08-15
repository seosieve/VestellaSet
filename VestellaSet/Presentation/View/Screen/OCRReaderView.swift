//
//  OCRReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

struct OCRReaderView: View {
    @ObservedObject var model: BeaconDataViewModel
    @Binding var path: NavigationPath
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
        .navigationDestination(for: Int.self) { value in
            BeaconConnectView(model: model, path: $path, macAddress: macAddress, item: item)
        }
        .onChange(of: isScanning) { _, scanning in
            isPresented = !scanning
            path.append(3)
        }
        .onAppear { isScanning = true }
        .onDisappear { isScanning = false }
    }
}
