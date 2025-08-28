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
        List(store.targetList, id: \.self) { target in
            HStack {
                Button {
                    store.send(.clickTargetCell)
                } label: {
                    Text(target)
                        .foregroundStyle(Color.monoWhite)
                        .font(Manrope.medium(size: 16))
                }
                Spacer()
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Spacing.s16)
            .listRowBackground(Color.monoShadow)
            .listRowSeparatorTint(Color.monoBlack)
            .listRowInsets(EdgeInsets())
        }
        .scrollContentBackground(.hidden)
        .background(Color.monoBlack)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
        .onAppear {
            store.send(.getTargetList)
        }
    }
}
