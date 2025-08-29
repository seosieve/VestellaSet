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
            let size = geometry.size.width - Radar.spacing
            
            ZStack {
                RadarBackgroundView(size: size)
                RadarBeamLineView(size: size)
                RadarBeamWedgeView(size: size)
                RadarDimView(size: size)
                RadarCenterView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
