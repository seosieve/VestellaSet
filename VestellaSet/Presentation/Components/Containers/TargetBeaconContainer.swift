//
//  TargetBeaconContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct TargetBeaconContainer: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            VStack(spacing: Spacing.s12) {
                HStack {
                    BeaconInfoView(type: .targetMajor(store.target))
                    DividerView(length: 32)
                    BeaconInfoView(type: .targetMinor(store.target))
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .glassBeaconInfoStyle()
                
                BeaconTypeLabel(title: TextMessage.targetBeacon)
            }
            .padding(.horizontal, Spacing.s20)
            .position(center)
            .offset(y: 88)
            .opacity(store.beacon == nil ? 0 : 1)
            .animation(.bouncy.delay(1.0), value: store.beacon)
        }
        .ignoresSafeArea()
    }
}
