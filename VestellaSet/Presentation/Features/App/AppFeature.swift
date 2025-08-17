//
//  AppFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var beaconDashBoard = BeaconDashBoardFeature.State()
        var navigationPath = StackState<AppPath>()
    }
    
    enum Action {
        case beaconDashBoard(BeaconDashBoardFeature.Action)
        case navigationPath(StackAction<AppPath, AppPathAction>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.beaconDashBoard, action: \.beaconDashBoard) { BeaconDashBoardFeature() }
        
        Reduce { state, action in
            switch action {
            case .navigationPath:
                return .none
            case .beaconDashBoard(.settingButtonTapped):
                state.navigationPath.append(.beaconSetting)
                return .none
            case .beaconDashBoard(.importButtonTapped):
                state.navigationPath.append(.beaconImport)
                return .none
            case .beaconDashBoard(.targetSelected):
                state.navigationPath.append(.beaconScanner)
                return .none
            case .beaconDashBoard(.beaconScanner(.testButtonTapped)):
                state.navigationPath.append(.beaconEditor)
                return .none
            case .beaconDashBoard(.beaconScanner(.backButtonTapped)):
                state.navigationPath.removeLast()
                return .none
            case .beaconDashBoard(.beaconScanner(.beaconEditor(.backButtonTapped))):
                state.navigationPath.removeLast(2)
                return .none
            case .beaconDashBoard(.beaconImport(.backButtonTapped)):
                state.navigationPath.removeLast()
                return .none
            case .beaconDashBoard(.beaconSetting(.backButtonTapped)):
                state.navigationPath.removeLast()
                return .none
            }
        }
    }
}
