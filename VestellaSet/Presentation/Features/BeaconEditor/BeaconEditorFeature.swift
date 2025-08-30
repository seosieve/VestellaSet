//
//  BeaconEditorFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconEditorFeature {
    @ObservableState
    struct State {
        var textMessage: String = TextMessage.detectingBeacon
    }
    
    enum Action {
        case clickBackButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                return .none
            }
        }
    }
}
