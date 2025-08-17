//
//  AppFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import ComposableArchitecture

@Reducer
struct Destination {
    @ObservableState
    enum State {
        case beaconConfig(BeaconConfigFeature.State)
        case beaconScanner(BeaconScannerFeature.State)
    }
    
    enum Action {
        case beaconConfig(BeaconConfigFeature.Action)
        case beaconScanner(BeaconScannerFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.beaconConfig, action: \.beaconConfig) { BeaconConfigFeature() }
        Scope(state: \.beaconScanner, action: \.beaconScanner) { BeaconScannerFeature() }
    }
}

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var dashboard = BeaconDashBoardFeature.State()
        var path = StackState<Destination.State>()
    }
    
    enum Action {
        case dashboard(BeaconDashBoardFeature.Action)
        case path(StackAction<Destination.State, Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.dashboard, action: \.dashboard) {
             BeaconDashBoardFeature()
         }
        
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            case .dashboard(.settingButtonTapped):
                state.path.append(.beaconConfig(BeaconConfigFeature.State()))
                return .none
            case .dashboard(.targetSelected):
                state.path.append(.beaconScanner(BeaconScannerFeature.State()))
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Destination()
        }
    }
}
