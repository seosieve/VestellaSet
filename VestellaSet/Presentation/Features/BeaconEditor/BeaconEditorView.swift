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
            if store.beacon == nil {
                RadarAnimationContainer()
                RadarOverlayContainer(store: store)
            }
            
            Button {
                store.send(.navigateToDashBoard)
            } label: {
                Text("DashBoard")
            }
            
            VStack {
                Spacer()
                if store.beacon != nil {
                    ActionButton(type: .write) {
                        store.send(.startConnecting)   
                    }
                }
            }
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.configureBeaconClient) }
    }
}
