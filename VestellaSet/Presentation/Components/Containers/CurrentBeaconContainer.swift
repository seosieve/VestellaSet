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
                Text("Current Beacon")
                    .font(Manrope.regular(size: 20))
                    .foregroundStyle(Color.monoDark)
                
                HStack {
                    BeaconInfoView(type: .major(store.beacon))
                    DividerView(length: 32)
                    BeaconInfoView(type: .minor(store.beacon))
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color.monoShadow.cornerRadius(Radius.s8))
                .padding(.horizontal, Spacing.s20)
            }
            .position(center)
            .offset(y: -100)
        }
        .ignoresSafeArea()
    }
}
