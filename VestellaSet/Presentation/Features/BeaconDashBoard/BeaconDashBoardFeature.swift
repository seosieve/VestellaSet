//
//  BeaconDashBoardFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconDashBoardFeature {
    @Dependency(\.userDefaults) var userDefaults
    
    @ObservableState
    struct State {
        var option: DashBoardOptionType = .all
        var targetList: [String] = []
        var completeList: [String: String] = [:]
        var percentage: Int { targetList.isEmpty ? 0 : completeList.count * 100 / targetList.count }
    }
    
    enum Action {
        case refreshData
        case changeOption(DashBoardOptionType)
        case clickImportButton
        case clickSettingButton
        case clickTargetCell(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refreshData:
                state.targetList = userDefaults.targetList()
                state.completeList = userDefaults.completeList()
                return .none
            case .changeOption(let option):
                state.option = option
                print(state.option)
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
