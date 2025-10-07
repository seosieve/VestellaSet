//
//  BeaconEditorView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import ComposableArchitecture

internal struct BeaconEditorView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        ZStack {
            RadarAnimationContainer(store: store)
            RadarProcessingLabel(store: store)
            IdentifierLabel(store: store)
            GlowAnimationView(store: store)
            CurrentBeaconContainer(store: store)
            TargetBeaconContainer(store: store)
            BaseContainerView(store: store)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        .onAppear { store.send(.onAppear) }
    }
}

private struct BaseContainerView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        VStack {
            HeaderContainerView(store: store)
            Spacer()
            WriteButton { store.send(.startConnecting) }
        }
        .opacity(store.beacon == nil ? 0 : 1)
        .animation(.easeInOut, value: store.beacon)
    }
}

private struct HeaderContainerView: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        HStack {
            BackButton { store.send(.navigateToDashBoard) }
                .opacity(store.isProcessing ? 0 : 1)
                .animation(.easeInOut, value: store.isProcessing)
            TargetInfoButton(store: store)
        }
    }
}


