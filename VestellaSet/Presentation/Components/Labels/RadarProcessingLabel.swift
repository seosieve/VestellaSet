//
//  RadarProcessingLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import SwiftUI
import ComposableArchitecture

struct RadarProcessingLabel: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        GeometryReader { geometry in
            let length = geometry.size.width - Spacing.s44 * 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            DottedLabel(text: store.textMessage)
                .font(Manrope.regular(size: 16))
                .position(center)
                .offset(y: -(length / 2) - Spacing.s72)
                .opacity(store.beacon == nil ? 1 : 0)
                .animation(.easeInOut, value: store.beacon)
        }
        .ignoresSafeArea()
    }
}
