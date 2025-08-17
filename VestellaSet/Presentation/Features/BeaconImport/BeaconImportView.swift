//
//  BeaconImportView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconImportView: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        Button {
            store.send(.backButtonTapped)
        } label: {
            Text("Back")
        }
        Text("BeaconImportView")
            .navigationBarBackButtonHidden()
    }
}
