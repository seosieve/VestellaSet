//
//  RadarBeamWedgeView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarBeamWedgeView: View {
    @State private var rotation: Double = 0
    @Environment(\.radarConfig) var config
    
    let startAngle: Angle = .degrees(-140)
    let endAngle: Angle = .degrees(-90)
    
    var body: some View {
        GradientWedge(startAngle: startAngle, endAngle: endAngle)
            .fill(AngularGradient(gradient: wedgeGradient, center: .center, startAngle: startAngle, endAngle: endAngle))
            .frame(width: config.length, height: config.length)
            .rotationEffect(.degrees(rotation))
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: rotation)
            .onAppear { rotation = 360 }
    }
    
    private var wedgeGradient: Gradient {
        return Gradient(colors: [Color.mintBase.opacity(0.0), Color.mintBase.opacity(0.3)])
    }
}

private struct GradientWedge: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}
