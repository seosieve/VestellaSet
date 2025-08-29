//
//  DashBoardProgressView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct DashBoardProgressView: View {
    var body: some View {
        HStack(spacing: Spacing.s4) {
            ZStack {
                Circle()
                    .stroke(Color.mintDark, lineWidth: 4)
                    .frame(width: 24, height: 24)
                
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(Color.mintBase, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 24, height: 24)
                    .rotationEffect(.degrees(-90))
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            
            Text("0%")
                .foregroundStyle(Color.monoWhite)
                .font(Manrope.bold(size: 16))
                .padding(.horizontal, Spacing.s4)
            
            Text("0")
                .foregroundStyle(Color.monoMedium)
                .font(Manrope.medium(size: 12))
            Capsule()
                .fill(Color.monoDark)
                .frame(width: 1)
                .frame(height: 8)
            Text("233")
                .foregroundStyle(Color.monoMedium)
                .font(Manrope.medium(size: 12))
            
        }
        .padding(.horizontal, Spacing.s12)
        .frame(height: 44)
        .background(Color.monoShadow)
        .cornerRadius(22)
    }
}

#Preview {
    DashBoardProgressView()
        .padding()
        .background(Color.black)
}
