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
        let filteredTargets: [String] = {
              switch store.option {
              case .all:
                  return store.targetList
              case .completed:
                  return store.targetList.filter { store.completeList[$0] != nil }
              case .incomplete:
                  return store.targetList.filter { store.completeList[$0] == nil }
              }
          }()
        
        ScrollView {
            LazyVStack(spacing: Spacing.zero) {
                ForEach(filteredTargets, id: \.self) { target in
                    ListItemButton(store: store, target: target)
                    ListDividerView(list: filteredTargets, index: filteredTargets.firstIndex(of: target) ?? 0)
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 1.0), value: store.option)
            .cornerRadius(Radius.s8)
            .padding(.horizontal, Spacing.s20)
        }
        .padding(.top, Spacing.s8)
    }
}
