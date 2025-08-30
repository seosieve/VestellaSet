//
//  GlassIconButtonModifier.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI

struct GlassIconButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(glassBackground())
            .overlay(outerGlow())
            .overlay(innerGlow())
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: Radius.s8, x: 2, y: 2)
            .shadow(color: .black.opacity(0.3), radius: Radius.s4, x: -1, y: 2)
    }
    
    private func glassBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.monoBlack.opacity(0.7), .monoShadow]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func outerGlow() -> some View {
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
    
    private func innerGlow() -> some View {
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
