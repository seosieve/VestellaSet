//
//  ScannerLineView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerLineView: View {
    var color: Color = .mintBase
    var lineWidth: CGFloat = 3
    var animationDuration: Double = 2
    var gradientHeight: CGFloat = 60

    @State private var offsetY: CGFloat = 0
    @State private var opacity: Double = 1.0

    var body: some View {
        GeometryReader { geometry in
            let h = geometry.size.height
            
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [color.opacity(opacity + 0.3), color.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: gradientHeight)
                .offset(y: offsetY)
                
                Rectangle()
                    .fill(color.opacity(opacity))
                    .frame(height: lineWidth)
                    .offset(y: offsetY)
            }
            .onAppear {
                offsetY = 0
                opacity = 1.0
                
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                        offsetY = h - lineWidth
                    }
                    withAnimation(.easeInOut(duration: animationDuration / 2).repeatForever(autoreverses: true)) {
                        opacity = 0.2
                    }
                }
            }
        }
    }
}
