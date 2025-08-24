//
//  GlassButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct GlassButton: View {
    var image: Image
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
            }
            .frame(width: 60, height: 40)
            .background(glassBackground())
            .cornerRadius(30)
            .overlay(outerGlow())
            .overlay(innerGlow())
            .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
            .shadow(color: .black.opacity(0.5), radius: 4, x: -1, y: 2)
          
        }
        .buttonStyle(BouncyButtonStyle())
    }
}

extension GlassButton {
    func glassBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.monoBlack.opacity(0.7), .monoShadow]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func outerGlow() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.5),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 2
            )
    }
    
    func innerGlow() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(1.0),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
