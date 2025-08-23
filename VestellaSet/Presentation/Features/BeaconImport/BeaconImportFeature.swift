//
//  BeaconImportFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconImportFeature {
    @ObservableState
    struct State {
        var isRunning: Bool = true
        var isScanning: Bool = true
    }
    
    enum Action {
        case stopRunning
        case stopScanning
        case clickBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .stopRunning:
                state.isRunning = false
                return .none
            case .stopScanning:
                state.isScanning = false
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
