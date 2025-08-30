//
//  RadarDimView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarDimView: View {
    @Environment(\.radarConfig) var config
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: dimGradient, startPoint: .top, endPoint: .bottom))
            .frame(width: config.length, height: config.length)
            .offset(y: 80)
    }
    
    private var dimGradient: Gradient {
        return Gradient(stops: [
            .init(color: Color.monoBlack.opacity(0.0), location: 0.0),
            .init(color: Color.monoBlack.opacity(1.0), location: 0.45)
        ])
    }
}
