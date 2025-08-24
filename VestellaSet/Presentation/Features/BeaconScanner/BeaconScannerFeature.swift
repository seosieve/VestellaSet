//
//  BeaconScannerFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconScannerFeature {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var isRunning: Bool = true
        var macAddress: String = ""
    }
    
    enum Action {
        case stopRunning
        case setMacAddress(String)
        case clickEditorButton
        case clickBackButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .stopRunning:
                state.isRunning = false
                return .none
            case .setMacAddress(let macAddress):
                state.macAddress = macAddress
                return .none
            case .clickEditorButton:
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
