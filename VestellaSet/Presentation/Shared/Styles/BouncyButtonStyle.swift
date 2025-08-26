//
//  BouncyButtonStyle.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct BouncyButtonStyle: ButtonStyle {
    let scalePercent: Int
    
    private var scale: CGFloat {
        CGFloat(scalePercent) / 100.0
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
            }
    }
}
