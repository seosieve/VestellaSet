//
//  RadarBeamLineView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarBeamLineView: View {
    @State private var rotation: Double = 0
    @Environment(\.radarConfig) var config
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: lineGradient, startPoint: .top, endPoint: .bottom))
            .frame(width: 4, height: config.length / 2)
            .offset(y: -(config.length / 4))
            .rotationEffect(.degrees(rotation))
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: rotation)
            .onAppear { rotation = 360 }
    }
    
    private var lineGradient: Gradient {
        return Gradient(stops: [
            .init(color: Color.mintBase.opacity(0.1), location: 0.0),
            .init(color: Color.mintBase.opacity(1.0), location: 0.4)
        ])
    }
}
