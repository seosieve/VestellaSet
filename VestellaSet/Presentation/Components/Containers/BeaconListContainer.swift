//
//  BeaconListContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconListContainer: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.zero) {
                ForEach(Array(store.targetList.enumerated()), id: \.element) { index, target in
                    ListItemButton(store: store, target: target)
                    ListDividerView(list: store.targetList, index: index)
                }
            }
            .cornerRadius(Radius.s8)
            .padding(.horizontal, Spacing.s20)
        }
        .padding(.top, Spacing.s8)
    }
}
