//
//  ScannerLineView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerLineView: View {
    @State private var offsetY: CGFloat = 0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let barHeight: CGFloat = 3
            let gradientHeight: CGFloat = 60
            let size = geometry.size.width - Spacing.normal * 2
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            ZStack {
                Rectangle()
                    .fill(Color.mintBase.opacity(opacity))
                    .frame(width: size, height: barHeight)
                    .position(x: centerX, y: centerY)
                    .offset(y: offsetY)
                
                LinearGradient(
                    gradient: Gradient(colors: [.mintBase.opacity(opacity + 0.3), .mintBase.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: size, height: gradientHeight)
                .position(x: centerX, y: centerY + gradientHeight / 2)
                .offset(y: offsetY)
            }
            .mask(
                RoundedRectangle(cornerRadius: Radius.normal)
                    .frame(width: size, height: size)
                    .position(x: centerX, y: centerY)
            )
            .onAppear {
                offsetY = -size / 2
                opacity = 1.0
                
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    offsetY = size / 2
                }
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    opacity = 0.2
                }
            }
        }
        .ignoresSafeArea()
    }
}
