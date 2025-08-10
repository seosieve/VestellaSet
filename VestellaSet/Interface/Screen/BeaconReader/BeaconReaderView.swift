//
//  BeaconReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

internal struct MacReaderView: View {
    @State private var recognizedText: String = "텍스트 없음"
    @State private var showScanner = false

    var body: some View {
        VStack(spacing: 20) {
            Button("📷 스캔 시작") {
                showScanner = true
            }

            Text("🔍 인식된 텍스트:")
                .font(.headline)
            
            Text(recognizedText)
                .padding()
            
            MacScannerView(recognizedText: $recognizedText)
                .frame(width: 200, height: 200)
            
        }
        .padding()
    }
}
