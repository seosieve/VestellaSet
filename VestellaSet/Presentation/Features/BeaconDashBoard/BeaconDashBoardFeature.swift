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
        case changeFilteredList
        case clickImportButton
        case clickSettingButton
        case clickTargetCell(String)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.makeFilteredList()
                return .none
                
            case .refreshData:
                state.targetList = userDefaults.targetList()
                state.completeList = userDefaults.completeList()
                return .run { send in await send(.changeFilteredList) }
                
            case .changeOption(let option):
                state.option = option
                return .run { send in await send(.changeFilteredList) }
                
            case .changeFilteredList:
                state.makeFilteredList()
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

extension BeaconDashBoardFeature.State {
    mutating func makeFilteredList() {
        let keywordFilteredList = targetList.filter { keyword.isEmpty || $0.contains(keyword) }
        switch option {
        case .all:
            filteredList = keywordFilteredList
        case .completed:
            filteredList = keywordFilteredList.filter { completeList[$0] != nil }
        case .incomplete:
            filteredList = keywordFilteredList.filter { completeList[$0] == nil }
        }
    }
}
