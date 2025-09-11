//
//  ListItemButton.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ListItemButton: View {
    let store: StoreOf<BeaconDashBoardFeature>
    let target: String
    
    var body: some View {
        Button(action: { store.send(.clickTargetCell(target)) }) {
            HStack(spacing: Spacing.s16) {
                Text(target)
                    .foregroundStyle(Color.monoWhite)
                    .font(Manrope.medium(size: 16))
                    .frame(width: 80, alignment: .leading)
                
                Text((store.completeList[target] ?? "").uppercased())
                    .foregroundStyle(Color.monoMedium)
                    .font(Manrope.medium(size: 16))
                
                Spacer()
                
                CheckCircleView()
                    .opacity(store.completeList[target] == nil ? 0 : 1)
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Spacing.s16)
            .background(Color.monoShadow)
            .simultaneousGesture(LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    Haptic.softImpact()
                }
            )
        }
    }
}
