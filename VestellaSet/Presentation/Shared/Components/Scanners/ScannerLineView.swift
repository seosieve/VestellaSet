//
//  ScannerLineView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerLineView: View {
    @Environment(\.scannerConfig) var config
    @State private var offsetY: CGFloat = 0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.mintBase.opacity(opacity))
                .frame(width: config.length, height: Scanner.lineWidth)
                .position(config.center)
                .offset(y: offsetY)
            
            LinearGradient(
                gradient: Gradient(colors: [.mintBase.opacity(opacity + 0.3), .mintBase.opacity(0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: config.length, height: Scanner.gradientHeight)
            .position(x: config.center.x, y: config.center.y + Scanner.gradientHeight / 2)
            .offset(y: offsetY)
        }
        .mask(
            RoundedRectangle(cornerRadius: Radius.normal)
                .frame(width: config.length, height: config.length)
                .position(config.center)
        )
        .onAppear {
            offsetY = -config.length / 2
            opacity = 1.0
            
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                offsetY = config.length / 2
            }
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                opacity = 0.2
            }
        }
    }
}
