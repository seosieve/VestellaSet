//
//  CurrentBeaconContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct CurrentBeaconContainer: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            VStack(spacing: Spacing.s12) {
                BeaconTypeLabel(title: "Current Beacon Info")
                
                HStack {
                    BeaconInfoView(type: .currentMajor(store.beacon))
                    DividerView(length: 32)
                    BeaconInfoView(type: .currentMinor(store.beacon))
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .glassBeaconInfoStyle()
            }
            .padding(.horizontal, Spacing.s20)
            .position(center)
            .offset(y: -88)
            .opacity(store.beacon == nil ? 0 : 1)
            .animation(.bouncy.delay(0.5), value: store.beacon)
        }
        .ignoresSafeArea()
    }
}
