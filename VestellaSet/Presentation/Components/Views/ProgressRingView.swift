//
//  ProgressRingView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ProgressRingView: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.mintDark, lineWidth: 4)
                .frame(width: 24, height: 24)
            
            Circle()
                .trim(from: 0, to: CGFloat(Double(store.percentage) / 100))
                .stroke(Color.mintBase, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 24, height: 24)
                .rotationEffect(.degrees(-90))
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}
