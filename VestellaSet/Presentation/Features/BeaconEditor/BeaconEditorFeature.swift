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
        var timeoutCounter: Int = 0
    }
    
    enum Action {
        case startScanning
        case increaseTimeoutCounter
        case navigateToScanner
        case navigateToDashBoard
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startScanning:
                beaconClient.setMacAddress(state.macAddress)
                beaconClient.startScanning()
                return .none
            case .increaseTimeoutCounter:
                state.timeoutCounter += 1
                print(state.timeoutCounter)
                return .none
            case .navigateToScanner:
                beaconClient.stopScanning()
                return .none
            case .navigateToDashBoard:
                beaconClient.stopScanning()
                return .none
            }
        }
    }
}
