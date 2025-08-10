//
//  BeaconQRView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/8/25.
//

import SwiftUI

internal struct BeaconQRView: View {
    @State private var scannedCode = "아직 스캔 안됨"
    
    var body: some View {
        VStack {
            Text("스캔된 코드:")
                .font(.headline)
            Text(scannedCode)
                .foregroundColor(.blue)
                .padding()
            ScanQRButton {
                print("버튼 눌림!")
            }
            
            QRScannerView(scannedCode: $scannedCode)
                .frame(height: 300)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .padding()
    }
}
