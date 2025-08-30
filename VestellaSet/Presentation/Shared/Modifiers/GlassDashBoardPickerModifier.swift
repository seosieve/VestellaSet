//
//  GlassDashBoardPickerModifier.swift
//  VestellaSet
//
//  Created by 서충원 on 8/28/25.
//

import SwiftUI

struct GlassDashBoardPickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(glassBackground())
            .overlay(outerGlow())
            .overlay(innerGlow())
            .cornerRadius(Radius.s8)
            .shadow(color: .black.opacity(0.2), radius: Radius.s8, x: 2, y: 2)
            .shadow(color: .black.opacity(0.3), radius: Radius.s4, x: -4, y: 2)
    }
    
    private func glassBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.monoShadow, .monoBlack.opacity(0.7)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func outerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.s8)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.02),
                        Color.white.opacity(0.2)
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
                        Color.white.opacity(0.04),
                        Color.white.opacity(0.04),
                        Color.white.opacity(0.04),
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
                        Color.white.opacity(0.06),
                        Color.white.opacity(0.06),
                        Color.white.opacity(0.04),
                        Color.white.opacity(0.6),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
