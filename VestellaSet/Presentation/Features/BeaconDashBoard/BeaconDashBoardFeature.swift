//
//  BeaconDashBoardFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconDashBoardFeature {
    @Dependency(\.userDefaultsClient) var userDefaults
    
    @ObservableState
    struct State {
        var option: DashBoardOptionType = .all
        var targetList: [String] = []
    }
    
    enum Action {
        case getTargetList
        case changeOption(DashBoardOptionType)
        case clickImportButton
        case clickSettingButton
        case clickTargetCell(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getTargetList:
                state.targetList = userDefaults.getTargetList()
                return .none
            case .changeOption(let option):
                state.option = option
                return .none
            case .clickImportButton:
                return .none
            case .clickSettingButton:
                return .none
            case .clickTargetCell:
                return .none
            }
        }
    }
}

