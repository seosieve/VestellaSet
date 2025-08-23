//
//  BeaconSettingFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconSettingFeature {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State { }
    
    enum Action {
        case clickBackButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
