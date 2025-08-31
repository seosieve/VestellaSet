//
//  BeaconEditorFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconEditorFeature {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var beaconClient: BeaconClient?
        var macAddress: String
        var textMessage: String = TextMessage.detectingBeacon
        var beacons: [MinewBeacon] = []
        var timeoutCounter: Int = 0
    }
    
    enum Action {
        case configureBeaconClient
        case updateBeacons([MinewBeacon])
        case increaseTimeoutCounter
        case navigateToScanner
        case navigateToDashBoard
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .configureBeaconClient:
                let client = BeaconClient()
                client.setMacAddress(state.macAddress)
                state.beaconClient = client
                return .run { send in
                    for await _ in client.increaseTimeoutCounter() {
                        await send(.increaseTimeoutCounter)
                    }
                }
            case .updateBeacons(let beacons):
                state.beacons = beacons
                print(state.beacons.map{ $0.mac })
                return .none
            case .increaseTimeoutCounter:
                state.timeoutCounter += 1
                switch state.timeoutCounter {
                case 3...:
                    return .send(.navigateToScanner)
                default:
                    return .none
                }
            case .navigateToScanner:
                return .none
            case .navigateToDashBoard:
                return .none
            }
        }
    }
}
