//
//  GlassActionButtonModifier.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI

struct GlassActionButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(glassBackground())
            .overlay(outerGlow())
            .overlay(innerGlow())
            .cornerRadius(Radius.s8)
            .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
            .shadow(color: .black.opacity(0.4), radius: 4, x: -1, y: 2)
    }
    
    private func glassBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.monoShadow.opacity(0.8), .monoBlack.opacity(0.85)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func outerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.s8)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.2),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.2),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 2
            )
    }
    
    private func innerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.s8)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.8),
                        Color.white.opacity(0.01),
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.01),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.09),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.01),
                        Color.white.opacity(0),
                        Color.white.opacity(0.01),
                        Color.white.opacity(0.5),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
