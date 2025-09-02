//
//  DashBoardProgressContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI
import ComposableArchitecture

struct DashBoardProgressContainer: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        HStack(spacing: Spacing.s4) {
            ProgressRingView(store: store)
            
            Text("\(store.percentage)%")
                .foregroundStyle(Color.monoWhite)
                .font(Manrope.bold(size: 16))
                .padding(.horizontal, Spacing.s4)
            
            Text("\(store.completeList.count)")
                .foregroundStyle(Color.monoMedium)
                .font(Manrope.medium(size: 12))
            
            Capsule()
                .fill(Color.monoDark)
                .frame(width: 1)
                .frame(height: 8)
            
            Text("\(store.targetList.count)")
                .foregroundStyle(Color.monoMedium)
                .font(Manrope.medium(size: 12))
        }
        .padding(.horizontal, Spacing.s12)
        .frame(height: 44)
        .background(Color.monoShadow)
        .cornerRadius(22)
    }
}
