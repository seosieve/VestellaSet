//
//  BeaconListView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconListView: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(Array(store.targetList.enumerated()), id: \.element) { index, target in
                    Button(action: { store.send(.clickTargetCell(target)) }) {
                        HStack(spacing: Spacing.s16) {
                            Text(target)
                                .foregroundStyle(Color.monoWhite)
                                .font(Manrope.medium(size: 16))
                            
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
                    }
                    
                    if index < store.targetList.count - 1 {
                        Rectangle().fill(Color.monoBlack).frame(height: 1)
                    }
                }
            }
            .cornerRadius(Radius.s8)
            .padding(.horizontal, Spacing.s20)
        }
        .padding(.top, Spacing.s8)
        .task(id: UUID()) { store.send(.refreshData) }
    }
}
