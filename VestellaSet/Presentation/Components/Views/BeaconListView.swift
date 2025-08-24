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
            Button {
                store.send(.clickTargetCell)
            } label: {
                Text(target)
                    .padding()
            }
            .listRowBackground(Color.monoShadow)
            .listRowSeparatorTint(Color.monoBlack)
        }
        .scrollContentBackground(.hidden)
        .background(Color.monoBlack)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
        .onAppear {
            store.send(.getTargetList)
        }
    }
}
