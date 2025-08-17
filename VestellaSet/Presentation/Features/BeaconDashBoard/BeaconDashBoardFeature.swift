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
    struct State { }
    
    enum Action {
        case settingButtonTapped
        case targetSelected
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .settingButtonTapped:
                print("aaaaaaaa")
                return .none
            case .targetSelected:
                print("bbbbbb")
                return .none
            }
        }
    }
}

