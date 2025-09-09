//
//  GlowAnimationView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture

struct GlowAnimationView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    @State private var glow = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.mintBase.opacity(0.5),
                            Color.mintBase.opacity(0.0)
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 60
                    )
                )
                .frame(width: 220, height: 220)
                .scaleEffect(glow ? 2.0 : 0.3)
                .opacity(glow ? 0.6 : 0.9)
                .blur(radius: Radius.s32)
                .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: glow)
            
            Circle()
                .fill(Color.mintBase.opacity(0.8))
                .frame(width: 36, height: 36)
                .blur(radius: Radius.s20)
        }
        .onAppear { glow.toggle() }
        .opacity(store.beacon == nil ? 0 : 1)
        .animation(.linear(duration: 3.0).delay(1.5), value: store.beacon)
    }
}
