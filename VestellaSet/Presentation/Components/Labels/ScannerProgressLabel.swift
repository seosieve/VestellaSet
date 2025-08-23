//
//  ScannerProgressLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct ScannerProgressLabel: View {
    @Environment(\.scannerConfig) var config
    @State private var dotCount: Int = 0
    
    var body: some View {
        Text("Scanning the QR code" + String(repeating: ".", count: dotCount))
            .foregroundStyle(Color.monoBase)
            .font(Manrope.bold(size: 16))
            .position(x: config.center.x, y: config.center.y + config.length / 2 + 40)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                    dotCount = (dotCount + 1) % 4
                }
            }
    }
}
