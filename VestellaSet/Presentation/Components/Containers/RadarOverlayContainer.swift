//
//  RadarOverlayContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import SwiftUI
import ComposableArchitecture

struct RadarOverlayContainer: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let length = geometry.size.width - Spacing.s44 * 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            VStack(spacing: Spacing.s8) {
                DottedLabel(text: store.textMessage)
                    .font(Manrope.regular(size: 16))
                Text(store.macAddress.uppercased())
                    .foregroundStyle(Color.monoWhite)
                    .font(Manrope.extraBold(size: 24))
            }
            .position(center)
            .offset(y: -(length / 2) - Spacing.s64)
            .opacity(store.beacon == nil ? 1 : 0)
            .animation(.easeInOut, value: store.beacon)
        }
        .ignoresSafeArea()
    }
}
