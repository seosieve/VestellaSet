//
//  BeaconDashBoardFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconDashBoardFeature {
    @ObservableState
    struct State {
        var beaconScanner = BeaconScannerFeature.State()
        var beaconImport = BeaconImportFeature.State()
        var beaconSetting = BeaconSettingFeature.State()
    }
    
    enum Action {
        case beaconScanner(BeaconScannerFeature.Action)
        case beaconImport(BeaconImportFeature.Action)
        case beaconSetting(BeaconSettingFeature.Action)
        case importButtonTapped
        case configButtonTapped
        case targetSelected
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.beaconImport, action: \.beaconImport) { BeaconImportFeature() }
        Scope(state: \.beaconScanner, action: \.beaconScanner) { BeaconScannerFeature() }
        Scope(state: \.beaconSetting, action: \.beaconSetting) { BeaconSettingFeature() }
        
        Reduce { state, action in
            switch action {
            case .importButtonTapped:
                return .none
            case .configButtonTapped:
                return .none
            case .targetSelected:
                return .none
            case .beaconScanner:
                return .none
            case .beaconImport:
                return .none
            case .beaconSetting:
                return .none
            }
        }
    }
}

