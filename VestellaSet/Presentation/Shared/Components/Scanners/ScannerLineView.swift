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
            let height = geometry.size.height
            
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [.mintBase.opacity(opacity + 0.3), .mintBase.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 60)
                .offset(y: offsetY)
                
                Rectangle()
                    .fill(Color.mintBase.opacity(opacity))
                    .frame(height: 3)
                    .offset(y: offsetY)
            }
            .onAppear {
                offsetY = 0
                opacity = 1.0
                
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        offsetY = height - 3
                    }
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        opacity = 0.2
                    }
                }
            }
        }
    }
}
