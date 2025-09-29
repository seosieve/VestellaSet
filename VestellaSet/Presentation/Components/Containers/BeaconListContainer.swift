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
        ZStack {
            ScrollView {
                VStack(spacing: Spacing.zero) {
                    ForEach(store.filteredList, id: \.self) { target in
                        ListItemButton(store: store, target: target)
                        ListDividerView(count: store.filteredList.count, index: store.filteredList.firstIndex(of: target) ?? 0)
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 1.0), value: store.filteredList)
                .cornerRadius(Radius.s8)
                .padding(.horizontal, Spacing.s20)
            }
            .padding(.top, Spacing.s8)
            
            EmptyBeaconListLabel(store: store)
        }
    }
}
