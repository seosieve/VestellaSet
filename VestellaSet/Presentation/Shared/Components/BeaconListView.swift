//
//  BeaconListView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI
import ComposableArchitecture

extension BeaconDashboardView {
    struct BeaconListView: View {
        let store: StoreOf<BeaconDashBoardFeature>
        @State var targetList: [String] = []
        
        var body: some View {
            List(targetList, id: \.self) { target in
                Button {
                    store.send(.clickTargetCell)
                } label: {
                    Text(target)
                        .padding()
                }
            }
            .onAppear {
                targetList = SettingRepository.shared.targetList
            }
        }
    }
}
