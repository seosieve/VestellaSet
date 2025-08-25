//
//  TextFieldContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/25/25.
//

import SwiftUI

struct TextFieldContainer: View {
    var body: some View {
        HStack {
            Text("UUID")
                .foregroundStyle(Color.white.opacity(0.7))
                .font(Manrope.regular(size: 16))
                .padding(.leading, 20)
                
            Spacer()
            Text("FJ234211313")
                .font(Manrope.bold(size: 16))
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 52)
        .background(glassBackground())
        .cornerRadius(Radius.small)
        .overlay(outerGlow())
        .overlay(innerGlow())
        .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
        .shadow(color: .black.opacity(0.5), radius: 4, x: -1, y: 2)
        .padding(.horizontal, Spacing.normal)
    }
}

extension TextFieldContainer {
    private func glassBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.monoShadow, .monoShadow.opacity(0.9)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func outerGlow() -> some View {
        RoundedRectangle(cornerRadius: Radius.small)
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
        RoundedRectangle(cornerRadius: Radius.small)
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.7),
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
