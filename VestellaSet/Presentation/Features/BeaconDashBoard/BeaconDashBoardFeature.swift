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
        var keyword: String = ""
        var targetList: [String] = []
        var completeList: [String: String] = [:]
        var filteredList: [String] = []
        var percentage: Int { targetList.isEmpty ? 0 : completeList.count * 100 / targetList.count }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case refreshData
        case changeOption(DashBoardOptionType)
        case changeFilteredList(DashBoardOptionType)
        case clickImportButton
        case clickSettingButton
        case clickTargetCell(String)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                print(state.keyword)
                if !state.keyword.isEmpty {
                    state.filteredList = state.targetList.filter { $0.contains(state.keyword) }
                }
                return .none
                
            case .refreshData:
                let option = state.option
                state.keyword = ""
                state.targetList = userDefaults.targetList()
                state.completeList = userDefaults.completeList()
                return .run { send in await send(.changeFilteredList(option)) }
                
            case .changeOption(let option):
                state.option = option
                return .run { send in await send(.changeFilteredList(option)) }
                
            case .changeFilteredList(let option):
                switch option {
                case .all:
                    state.filteredList = state.targetList
                case .completed:
                    state.filteredList = state.targetList.filter { state.completeList[$0] != nil }
                case .incomplete:
                    state.filteredList = state.targetList.filter { state.completeList[$0] == nil }
                }
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
