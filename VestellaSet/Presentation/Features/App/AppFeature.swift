//
//  AppFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import ComposableArchitecture

enum AppPath: Hashable {
    case beaconImport
    case beaconConfig
    case beaconScanner
    case beaconEditor
}

enum AppPathAction {
    case beaconImport(BeaconImportFeature.Action)
    case beaconConfig(BeaconSettingFeature.Action)
    case beaconScanner(BeaconScannerFeature.Action)
    case beaconEditor(BeaconEditorFeature.Action)
}

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var dashboard = BeaconDashBoardFeature.State()
        var path = StackState<AppPath>()
    }
    
    enum Action {
        case dashboard(BeaconDashBoardFeature.Action)
        case path(StackAction<AppPath, AppPathAction>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.dashboard, action: \.dashboard) {
            BeaconDashBoardFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            case .dashboard(.configButtonTapped):
                state.path.append(.beaconConfig)
                return .none
            case .dashboard(.importButtonTapped):
                state.path.append(.beaconImport)
                return .none
            case .dashboard(.targetSelected):
                state.path.append(.beaconScanner)
                return .none
            case .dashboard(.beaconScanner(.testButtonTapped)):
                state.path.append(.beaconEditor)
                return .none
            case .dashboard(.beaconScanner(.backButtonTapped)):
                state.path.removeLast()
                return .none
            case .dashboard(.beaconScanner(.beaconEditor(.backButtonTapped))):
                state.path.removeLast(2)
                return .none
            case .dashboard(.beaconImport(.backButtonTapped)):
                state.path.removeLast()
                return .none
            case .dashboard(.beaconSetting(.backButtonTapped)):
                state.path.removeLast()
                return .none
            }
        }
    }
}
