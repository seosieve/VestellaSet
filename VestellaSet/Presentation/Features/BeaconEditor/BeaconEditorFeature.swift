//
//  BeaconEditorFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconEditorFeature {
    @Dependency(\.userDefaults) var userDefaults
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var uuid: String = ""
        var interval: Int = 1
        var power: Int = 1
        var beaconClient: BeaconClient?
        var target: String
        var identifier: String
        var textMessage: String = TextMessage.detectingBeacon
        var beacon: MinewBeacon? = nil
        var timeoutCounter: Int = 0
        var connectionState: ConnectionState = .disconnected
        var isProcessing: Bool = false
    }
    
    enum Action {
        case onAppear
        case configureBeaconClient
        case updateBeacon(MinewBeacon)
        case updateConnectionState(ConnectionState)
        case increaseTimeoutCounter
        case startConnecting
        case startWritting
        case appendCompleteList
        case navigateToScanner(String)
        case navigateToDashBoard
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.uuid = userDefaults.uuid()
                state.interval = userDefaults.broadcastInterval()
                state.power = userDefaults.transmissionPower()
                return .run { send in
                    await send(.configureBeaconClient)
                }
                
            case .configureBeaconClient:
                let client = BeaconClient()
                client.setIdentifier(state.identifier)
                state.beaconClient = client
                return .run { send in
                    async let notFoundTask: Void = {
                        for await _ in client.onBeaconNotFound {
                            await send(.increaseTimeoutCounter)
                        }
                    }()
                    
                    async let foundTask: Void = {
                        for await beacon in client.onBeaconFound {
                            await send(.updateBeacon(beacon))
                        }
                    }()
                    
                    async let connectTask: Void = {
                        for await connection in client.onBeaconConnect {
                            await send(.updateConnectionState(connection))
                        }
                    }()
                    
                    _ = await (notFoundTask, foundTask, connectTask)
                }
                
            case .increaseTimeoutCounter:
                state.timeoutCounter += 1
                switch state.timeoutCounter {
                case 3...:
                    return .send(.navigateToScanner(state.target))
                default:
                    return .none
                }
                
            case .updateBeacon(let beacon):
                state.beacon = beacon
                return .none
                
            case .updateConnectionState(let connection):
                state.connectionState = connection
                switch state.connectionState {
                case .connecting:
                    print("🩵 connecting")
                    return .none
                case .connected:
                    print("🩵 connected")
                    return .send(.startWritting)
                case .disconnected:
                    print("🩵 disconnected")
                    return .send(.navigateToDashBoard)
                case .connectFailed:
                    print("🩵 connectFailed")
                    return .none
                default:
                    return .none
                }
                
            case .startConnecting:
                state.beaconClient?.startConnecting(state.beacon)
                state.isProcessing = true
                return .none
                
            case .startWritting:
                let target = state.target
                let uuid = userDefaults.uuid()
                let interval = userDefaults.broadcastInterval()
                let power = userDefaults.transmissionPower()
                
                state.beaconClient?.startWritting(target, uuid, interval, power)
                return .run { send in
                    await send(.appendCompleteList)
                }
                
            case .appendCompleteList:
                userDefaults.appendCompleteList(state.target, state.identifier)
                return .none
                
            case .navigateToScanner:
                return .none
                
            case .navigateToDashBoard:
                return .none
            }
        }
    }
}
