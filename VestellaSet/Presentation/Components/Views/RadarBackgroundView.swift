//
//  RadarBackgroundView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarBackgroundView: View {
    @Environment(\.radarConfig) var config
    
    var body: some View {
        Circle()
            .foregroundStyle(Color.black.opacity(0.2))
            .frame(width: config.length, height: config.length)
            .position(config.center)
        
        Circle()
            .foregroundStyle(Color.black.opacity(0.3))
            .frame(width: config.length * 0.75, height: config.length * 0.75)
            .position(config.center)
    }
}
