//
//  MacAddressLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 9/4/25.
//

import SwiftUI
import ComposableArchitecture

struct MacAddressLabel: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let length = geometry.size.width - Spacing.s44 * 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            Text(store.macAddress.uppercased())
                .foregroundStyle(Color.monoWhite)
                .font(Manrope.extraBold(size: 24))
                .position(center)
                .offset(y: store.beacon != nil ? -(length / 2) - Spacing.s64 : -(length / 2) - Spacing.s40)
                .animation(.bouncy.delay(0.5), value: store.beacon)
        }
        .ignoresSafeArea()
    }
}
