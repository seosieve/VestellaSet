//
//  ScannerLineView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerLineView: View {
    let store: StoreOf<BeaconImportFeature>
    
    @Environment(\.scannerConfig) var config
    @State private var offsetY: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.mintBase.opacity(opacity))
                .frame(width: config.length, height: Scanner.lineWidth)
                .position(config.center)
                .offset(y: offsetY)
            
            LinearGradient(
                gradient: Gradient(colors: [.mintBase.opacity(opacity == 0 ? 0 : opacity + 0.3), .mintBase.opacity(0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: config.length, height: Scanner.gradientHeight)
            .position(x: config.center.x, y: config.center.y + Scanner.gradientHeight / 2 - Scanner.lineWidth)
            .offset(y: offsetY)
            .opacity(store.isRunning ? 0 : 1)
        }
        .mask(
            RoundedRectangle(cornerRadius: Radius.s12)
                .frame(width: config.length, height: config.length)
                .position(config.center)
        )
        .onAppear {
            offsetY = -config.length / 2
        }
        .onChange(of: store.isRunning) {
            opacity = 1.0
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                offsetY = config.length / 2
            }
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                opacity = 0.2
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.6)) {
                    opacity = 0
                }
            }
        }
    }
}
