//
//  MacReaderView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI

struct MacReaderView: View {
    @ObservedObject var model: BeaconDataViewModel
    @State private var recognizedText: String = "텍스트 없음"
    let item: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🔍 인식된 텍스트:")
                .font(.headline)
            
            Text(recognizedText)
                .padding()
            
            OCRScanner(result: $recognizedText)
                .frame(width: 200, height: 200)
            
            setButton
        }
        .padding()
    }
}

// MARK: - UI Components
extension MacReaderView {
    private var setButton: some View {
        NavigationLink(destination: BeaconListView(model: model, macAddress: getMacAddress(), item: item)) {
            Text("Set")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
}

// MARK: - Methods
extension MacReaderView {
    func getMacAddress() -> String {
        return String(recognizedText.prefix(12)).lowercased()
    }
}
