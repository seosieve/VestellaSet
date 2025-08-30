//
//  BeaconEditorFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconEditorFeature {
    @Dependency(\.beaconClient) var beaconClient
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var macAddress: String
        var textMessage: String = TextMessage.detectingBeacon
    }
    
    enum Action {
        case startScanning
        case navigateToScanner
        case navigateToDashBoard
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startScanning:
                beaconClient.startScanning()
                return .none
            case .navigateToScanner:
                beaconClient.stopScanning()
                return .run { _ in await self.dismiss() }
            case .navigateToDashBoard:
                beaconClient.stopScanning()
                return .none
            }
        }
    }
}
