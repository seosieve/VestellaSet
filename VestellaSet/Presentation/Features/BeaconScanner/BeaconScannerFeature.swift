//
//  BeaconScannerFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconScannerFeature {
    @ObservableState
    struct State {
        var beaconEditor = BeaconEditorFeature.State()
    }
    
    enum Action {
        case beaconEditor(BeaconEditorFeature.Action)
        case backButtonTapped
        case testButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.beaconEditor, action: \.beaconEditor) { BeaconEditorFeature() }
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .none
            case .testButtonTapped:
                print("f")
                return .none
            case .beaconEditor:
                return .none
            }
        }
    }
}
