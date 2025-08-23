//
//  ScannerProgressLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct ScannerProgressLabel: View {
    @Environment(\.scannerConfig) var config
    
    var body: some View {
        Text("Scanning the QR code...")
             .foregroundStyle(Color.monoBase)
             .font(Manrope.bold(size: 20))
             .position(x: config.center.x, y: config.center.y + config.length / 2 + 40)
    }
}
