//
//  BeaconDashboardView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconDashboardView: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        VStack {
            DashBoardHeaderContainer(store: store)
            DashBoardTextFieldView(store: store)
            DashBoardPickerContainer(store: store)
            DashBoardSortButton()
            BeaconListContainer(store: store)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.refreshData) }
        .task { printMyAppUserDefaults() }
    }
}

// MARK: - Methods
extension BeaconDashboardView {
    func printMyAppUserDefaults() {
        let prefix = UserDefaultsKey.prefix
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        for (key, value) in dictionary where key.hasPrefix(prefix) {
            if key != UserDefaultsKey.targetList {
                print("🕹️ \(key) : \(value)")
            }
        }
    }
}
