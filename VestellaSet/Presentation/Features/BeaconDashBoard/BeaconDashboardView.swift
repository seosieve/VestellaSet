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
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            DashBoardHeaderContainer(store: store)
            DashBoardTextFieldView(store: store, isFocused: $isFocused)
            DashBoardPickerContainer(store: store)
            DashBoardSortButton()
            BeaconListContainer(store: store, isFocused: $isFocused)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.refreshData) }
        .onTapGesture { isFocused = false }
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
            if key == UserDefaultsKey.uuid || key == UserDefaultsKey.transmissionPower || key == UserDefaultsKey.broadcastInterval {
                print("🕹️ \(key) : \(value)")
            }
        }
    }
}
