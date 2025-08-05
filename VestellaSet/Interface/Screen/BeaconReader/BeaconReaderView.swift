//
//  BeaconReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

internal struct BeaconReaderView: View {
    @State private var recognizedText: String = "텍스트 없음"
    @State private var showScanner = false

    var body: some View {
        VStack(spacing: 20) {
            Button("📷 스캔 시작") {
                showScanner = true
            }

            Text("🔍 인식된 텍스트:")
                .font(.headline)
            
            ScrollView {
                Text(recognizedText)
                    .padding()
            }
        }
        .sheet(isPresented: $showScanner) {
            BeaconScannerView { result in
                switch result {
                case .success(let text):
                    recognizedText = text
                case .failure(let error):
                    recognizedText = "오류: \(error.localizedDescription)"
                }
            }
        }
        .padding()
    }
}
