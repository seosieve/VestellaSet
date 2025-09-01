//
//  BeaconEditorView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin
import ComposableArchitecture

internal struct BeaconEditorView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        ZStack {
            RadarAnimationContainer(store: store)
            RadarOverlayContainer(store: store)
            
            VStack {
                BackButton { store.send(.navigateToDashBoard) }
                Spacer()
                ActionButton(type: .write) { store.send(.startConnecting) }
            }
            .opacity(store.beacon == nil ? 0 : 1)
            .animation(.easeInOut, value: store.beacon)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.configureBeaconClient) }
    }
}
