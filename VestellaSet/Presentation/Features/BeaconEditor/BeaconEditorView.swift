//
//  BeaconEditorView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin
import ComposableArchitecture

internal struct BeaconEditorView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        ZStack {
            RadarAnimationContainer(store: store)
            RadarOverlayContainer(store: store)
            FireflyGlow()
            CurrentBeaconContainer(store: store)
            TargetBeaconContainer(store: store)
            
            VStack {
                BackButton { store.send(.navigateToDashBoard) }
                    .opacity(store.isProcessing ? 0 : 1)
                    .animation(.easeInOut, value: store.isProcessing)
                Spacer()
                ActionButton(type: .write) { store.send(.startConnecting) }
            }
            .opacity(store.beacon == nil ? 0 : 1)
            .animation(.easeInOut, value: store.beacon)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.configureBeaconClient) }
    }
}

struct FireflyGlow: View {
    @State private var glow = false
    
    var body: some View {
        ZStack {
            // 퍼지는 빛 (blur + scale)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.mintBase.opacity(0.5),
                            Color.mintBase.opacity(0.0) // 경계 흐리게
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 60
                    )
                )
                .frame(width: 220, height: 220)
                .scaleEffect(glow ? 2.0 : 0.3)
                .opacity(glow ? 0.6 : 0.9)
                .blur(radius: 30) // 경계 흐림
                .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: glow)
            
            // 중심 코어 (blur 처리로 부드럽게)
            Circle()
                .fill(Color.mintBase.opacity(0.8))
                .frame(width: 36, height: 36)
                .blur(radius: 20) // 중심부도 날카롭지 않게
        }
        .onAppear { glow.toggle() }
    }
}
