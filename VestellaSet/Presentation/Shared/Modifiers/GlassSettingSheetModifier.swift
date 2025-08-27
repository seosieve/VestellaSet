//
//  GlassSettingSheetModifier.swift
//  VestellaSet
//
//  Created by 서충원 on 8/27/25.
//

import SwiftUI

struct GlassSettingSheetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.monoBlack.opacity(0.7))
            .overlay(outerGlow())
            .overlay(innerGlow())
            .cornerRadius(Radius.s12)
            .shadow(radius: Radius.s8)
    }
    
    private func outerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.s12)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.1),
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
                        Color.white.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 3
            )
    }
    
    private func innerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.s12)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.05),
                        Color.white.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}

