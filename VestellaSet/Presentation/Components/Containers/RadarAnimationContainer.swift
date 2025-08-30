//
//  RadarAnimationContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarAnimationContainer: View {
    var body: some View {
        GeometryReader { geometry in
            let length = geometry.size.width - Spacing.s44 * 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                RadarBackgroundView()
                RadarBeamLineView()
                RadarBeamWedgeView()
                RadarDimView()
                RadarCenterView()
            }
            .environment(\.radarConfig, RadarConfig(length: length, center: center))
        }
        .ignoresSafeArea()
    }
}
