//
//  ScannerDimView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct ScannerDimView: View {
    @Environment(\.scannerConfig) var config
    
    var body: some View {
        Color.monoBlack.opacity(0.9)
            .mask(
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .compositingGroup()
                        .luminanceToAlpha()
                    
                    RoundedRectangle(cornerRadius: Radius.s12)
                        .frame(width: config.length, height: config.length)
                        .blendMode(.destinationOut)
                        .position(config.center)
                }
            )
            .allowsHitTesting(false)
    }
}
