//
//  ConfigButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingButton: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        Button {
            store.send(.settingButtonTapped)
        } label: {
            Text("Setting")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}
