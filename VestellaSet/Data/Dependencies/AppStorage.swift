//
//  AppStorage.swift
//  VestellaSet
//
//  Created by 서충원 on 8/24/25.
//

import Foundation
import ComposableArchitecture

struct AppStorage {
    var getTargetList: () -> [String]
    var setTargetList: ([String]) -> Void
}

extension DependencyValues {
    var appStorage: AppStorage {
        get { self[AppStorageKey.self] }
        set { self[AppStorageKey.self] = newValue }
    }
}

private enum AppStorageKey: DependencyKey {
    static let liveValue: AppStorage = AppStorage(
        getTargetList: { UserDefaults.standard.stringArray(forKey: UserDefaultsKey.targetList) ?? [] },
        setTargetList: { UserDefaults.standard.set($0, forKey: UserDefaultsKey.targetList) }
    )
}
